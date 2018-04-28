//
//  NetworkUtility.swift
//  INSTACK
//
//  Created by fahad c h on 31/03/18.
//  Copyright © 2018 Litmus7. All rights reserved.
//

import Foundation
import SwiftyJSON

public typealias ParametersDict = [String : Any?]
public typealias HeadersDict = [String: String]

/// Possible networking error
public enum NetworkError: Error {
    case dataIsNotEncodable(_: Any)
    case dataIsNotDecodable(_: Any)
    case stringFailedToDecode(_: Data, encoding: String.Encoding)
    case invalidURL(_: String)
    case error(_: ResponseProtocol)
    case noResponse(_: ResponseProtocol)
    case missingEndpoint
    case failedToParseJSON(_: JSON, _: ResponseProtocol)
}

struct Constants {
    
    public enum ServerConfig: String {
        case endpoint   =    "endpoint"
        case base       =    "base"
        case pathAPI    =    "path"
        case name       =    "name"
        case headers    =    "headers"
        case apiKey     =    "apiAccessKey"
    }
}

public enum RequestMethod: String {
    case get    = "GET"
    case post    = "POST"
    case put    = "PUT"
    case delete    = "DELETE"
}

public extension String {
    
    public func fill(withValues dict: [String : Any?]?) -> String {
        guard let data = dict else {
            return self
        }
        var finalString = self
        data.forEach { arg in
            if let unwrappedValue = arg.value {
                finalString = finalString.replacingOccurrences(of: "{\(arg.key)}", with: String(describing: unwrappedValue))
            }
        }
        return finalString
    }
    
    public func stringByAdding(urlEncodedFields fields: ParametersDict?) throws -> String {
        guard let f = fields else { return self }
        return try f.urlEncodedString(base: self)
    }
}

public extension Dictionary where Key == String, Value == Any? {
    
    /// Encode a dictionary as url encoded string
    ///
    /// - Parameter base: base url
    /// - Returns: encoded string
    /// - Throws: throw `.dataIsNotEncodable` if data cannot be encoded
    
    public func urlEncodedString(base: String = "") throws -> String {
        guard self.count > 0 else { return "" } // nothing to encode
        let items: [URLQueryItem] = self.flatMap { (key,value) in
            guard let v = value else { return nil } // skip item if no value is set
            return URLQueryItem(name: key, value: String(describing: v))
        }
        var urlComponents = URLComponents(string: base)!
        urlComponents.queryItems = items
        guard let encodedString = urlComponents.url else {
            throw NetworkError.dataIsNotEncodable(self)
        }
        return encodedString.absoluteString
    }
    
}
