//
//  Service.swift
//  INSTACK
//
//  Created by fahad c h on 31/03/18.
//  Copyright © 2018 Litmus7. All rights reserved.
//

import Foundation
import Alamofire

class Service: ServiceProtocol {
    var configuration: ServiceConfig
    lazy var sessionManager: SessionManager = Alamofire.SessionManager.default
    
    var headers: HeadersDict
    
    required init(configuration: ServiceConfig, retrier: RequestRetrier, adapter: RequestAdapter) {
        self.configuration = configuration
        self.headers = configuration.headers
        sessionManager.retrier = retrier
        sessionManager.adapter = adapter
    }
    
    func execute(request: RequestProtocol, completion: @escaping (ResponseProtocol) -> Void) {
        do {
            let dataRequest = try sessionManager.request(request.urlRequest(in: self))
            dataRequest.response(completionHandler: { (responseData) in
                let parsedResponse = Response(afResponse: responseData, request: request)
                completion(parsedResponse)
            })
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
}
