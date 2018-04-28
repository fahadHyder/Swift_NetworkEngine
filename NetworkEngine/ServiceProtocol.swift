//
//  ServiceProtocol.swift
//  INSTACK
//
//  Created by fahad c h on 31/03/18.
//  Copyright © 2018 Litmus7. All rights reserved.
//

import Foundation
import Alamofire

public protocol ServiceProtocol {
    var configuration: ServiceConfig { get }
    var headers: HeadersDict { get set }
    init(configuration: ServiceConfig, retrier: RequestRetrier, adapter: RequestAdapter)
    func execute(request: RequestProtocol, completion: @escaping (ResponseProtocol) -> Void)
}

