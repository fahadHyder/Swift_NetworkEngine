//
//  ServiceConfig.swift
//  INSTACK
//
//  Created by fahad c h on 31/03/18.
//  Copyright © 2018 Litmus7. All rights reserved.
//

import Foundation
import SwiftyJSON


public final class ServiceConfig {
    
    private(set) var name: String
    private(set) var url: URL
    private(set) var headers: HeadersDict = [:]
    
    public var timeout: TimeInterval = 15.0
    public var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    public static var apiKey: String?
    
    public init?(name: String? = nil, base urlString: String) {
        guard let url = URL(string: urlString) else {
            return nil
        }
        self.url = url
        self.name = name ?? (url.host ?? "")
    }
    
    public convenience init?() {
        //get server configuration from Info.plist, This is one way of get service information.You could write your own service config
        
        let appCnfg = JSON(Bundle.main.object(forInfoDictionaryKey: Constants.ServerConfig.endpoint.rawValue) as Any)
        guard let base = appCnfg[Constants.ServerConfig.base.rawValue].string else {
            return nil
        }
        
        self.init(name: appCnfg[Constants.ServerConfig.name.rawValue].string, base: base)
        
        if let fixedHeaders = appCnfg[Constants.ServerConfig.headers.rawValue].dictionaryObject as? HeadersDict {
            self.headers = fixedHeaders
        }
        
    }
}
