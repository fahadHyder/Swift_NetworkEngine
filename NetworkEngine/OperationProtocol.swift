//
//  OperationProtocol.swift
//  INSTACK
//
//  Created by fahad c h on 01/04/18.
//  Copyright © 2018 Litmus7. All rights reserved.
//

import Foundation

protocol OperationProtocol {
    associatedtype T
    var request: RequestProtocol? { get set }
    func execute(in service: ServiceProtocol, completion: @escaping (_ response: T?, _ resultType: Response.ResultType) -> Void)
}
