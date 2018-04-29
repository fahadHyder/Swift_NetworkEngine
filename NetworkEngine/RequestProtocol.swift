//
//  RequestProtocol.swift
//
//  Created by fahad c h on 01/04/18.
//  Copyright © 2018 FahadHyder. All rights reserved.
//

import Foundation

public protocol RequestProtocol {
    
    var endpoint: String { get set }
    var method: RequestMethod? { get set }
    // For example `{ "p1" : "abc", "p2" : null, "p3" : 3 }` will be `.../endpoint?p1=abc&p3=3`
    var fields: ParametersDict? { get set }
    
    // Example: `/v2/articles/{table_id}/{article_id}/` will be composed by replacing `{table_id}` and `{article_id]`
    var urlParams: ParametersDict? { get set }
    var headers: HeadersDict? { get set }
    var cachePolicy: URLRequest.CachePolicy? { get set }
    var body: RequestBody? { get set }
    var timeout: TimeInterval? { get set }
    
    // Returns full header ie, Service headers+ Request headers
    // in case of duplicate service header value will be replaced with request header value
    func headers(in service: ServiceProtocol) -> HeadersDict
    
    // Returns the full url
    
    func url(in service: ServiceProtocol) throws -> URL
    
    // Returns URLRequest
    
    func urlRequest(in service: ServiceProtocol) throws -> URLRequest
}

public extension RequestProtocol {
    
    public func headers(in service: ServiceProtocol) -> HeadersDict {
        var params: HeadersDict = service.headers
        self.headers?.forEach({ (k,v) in params[k] = v })
        return params
    }
    
    public func url(in service: ServiceProtocol) throws -> URL {
        let baseURL = service.configuration.url.absoluteString.appending(self.endpoint)
        let fullURLString = try baseURL.fill(withValues: self.urlParams).stringByAdding(urlEncodedFields: self.fields)
        guard let url = URL(string: fullURLString) else {
            throw NetworkError.invalidURL(fullURLString)
        }
        return url
    }
    
    public func urlRequest(in service: ServiceProtocol) throws -> URLRequest {
        let requestURL = try self.url(in: service)
        let cachePolicy = self.cachePolicy ?? service.configuration.cachePolicy
        let headers = self.headers(in: service)
        let timeout = service.configuration.timeout
        
        var urlRequest = URLRequest(url: requestURL, cachePolicy: cachePolicy, timeoutInterval: timeout)
        urlRequest.httpMethod = (self.method ?? .get ).rawValue
        urlRequest.allHTTPHeaderFields = headers
        if let bodyData = try self.body?.encodedData() {
            urlRequest.httpBody = bodyData
        }
        return urlRequest
    }
}

public struct RequestBody {
    
    let data: Any
    
    let encoding: Encoding
    
    public enum Encoding {
        case rawData
        case rawString(_: String.Encoding?)
        case json
    }
    

    private init(_ data: Any, as encoding: Encoding = .json) {
        self.data = data
        self.encoding = encoding
    }
    
    public static func json(_ data: Any) -> RequestBody {
        return RequestBody(data, as: .json)
    }
    
    public static func raw(data: Data) -> RequestBody {
        return RequestBody(data, as: .rawData)
    }
    

    public static func raw(string: String, encoding: String.Encoding? = .utf8) -> RequestBody {
        return RequestBody(string, as: .rawString(encoding))
    }

    /// Encoded data to carry out with the request
    ///
    /// - Returns: Data
    public func encodedData() throws -> Data {
        switch self.encoding {
        case .rawData:
            return self.data as! Data
        case .rawString(let encoding):
            guard let string = (self.data as! String).data(using: encoding ?? .utf8) else {
                throw NetworkError.dataIsNotEncodable(self.data)
            }
            return string
        case .json:
            let jsonObject = try JSONSerialization.data(withJSONObject: self.data, options: [.prettyPrinted])
            return jsonObject
        }
    }
    
    public func encodedString(_ encoding: String.Encoding = .utf8) throws -> String {
        let encodedData = try self.encodedData()
        guard let stringRepresentation = String(data: encodedData, encoding: encoding) else {
            throw NetworkError.stringFailedToDecode(encodedData, encoding: encoding)
        }
        return stringRepresentation
    }
}
