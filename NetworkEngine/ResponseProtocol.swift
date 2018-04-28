//
//  ResponseProtocol.swift
//  INSTACK
//
//  Created by fahad c h on 31/03/18.
//  Copyright © 2018 Litmus7. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

public protocol ResponseProtocol {
    var type: Response.ResultType { get }
    var request: RequestProtocol { get }
    var httpResponse: HTTPURLResponse? { get }
    var httpStatusCode: Int? { get }
    var data: Data? { get }
    
    func toJSON() throws -> JSON
    
}

public class Response: ResponseProtocol {
    public var type: Response.ResultType
    
    public var request: RequestProtocol
    
    public var httpResponse: HTTPURLResponse?
    
    public var data: Data?
    
    
    public enum ResultType {
        case error(_:Int)
        case success(_:Int)
        case noResponse
        
        private static let successCodes: Range<Int> = 200..<299
        
        public static func from(response: HTTPURLResponse?) -> ResultType {
            guard let r = response else {
                return .noResponse
            }
            return (ResultType.successCodes.contains(r.statusCode) ? .success(r.statusCode) : .error(r.statusCode))
        }
        
        public var code: Int? {
            switch self {
            case .error(let code): return code
            case .success(let code): return code
            case .noResponse: return nil
            }
        }
        
        public var errorString: String? {
            if let code = self.code {
                return HTTPURLResponse.localizedString(forStatusCode: code)
            }
            return nil
        }
    }
    
    
    public var httpStatusCode: Int? {
        return self.type.code
    }
    
    public init(afResponse response: DefaultDataResponse, request: RequestProtocol) {
        self.type = ResultType.from(response: response.response)
        self.httpResponse = response.response
        self.data = response.data
        self.request = request
    }
    
    public func toJSON() throws -> JSON {
        return try JSON(data: self.data ?? Data())
    }
    
    public func toString(_ encoding: String.Encoding? = nil) -> String? {
        guard let d = self.data else { return nil }
        return String(data: d, encoding: encoding ?? .utf8)
    }
}
