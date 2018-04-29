//
//  Request.swift
//
//  Created by fahad c h on 01/04/18.
//  Copyright © 2018 FahadHyder. All rights reserved.
//

import Foundation

public class Request: RequestProtocol {
    
    public var endpoint: String
    
    public var method: RequestMethod?
    
    public var fields: ParametersDict?
    
    public var urlParams: ParametersDict?
    
    public var cachePolicy: URLRequest.CachePolicy?
    
    public var headers: HeadersDict?
    
    public var body: RequestBody?
    
    public var timeout: TimeInterval?

    public init(method: RequestMethod = .get, endpoint: String = "", params: ParametersDict? = nil, fields: ParametersDict? = nil, body: RequestBody? = nil) {
        self.method = method
        self.endpoint = endpoint
        self.urlParams = params
        self.fields = fields
        self.body = body
    }
}
