//
//  ServiceProtocol.swift
//
//  Created by fahad c h on 01/04/18.
//  Copyright © 2018 FahadHyder. All rights reserved.
//

import Foundation
import Alamofire

public protocol ServiceProtocol {
    var configuration: ServiceConfig { get }
    var headers: HeadersDict { get set }
    init(configuration: ServiceConfig)
    func execute(request: RequestProtocol, completion: @escaping (ResponseProtocol) -> Void)
}

