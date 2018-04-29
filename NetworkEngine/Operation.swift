//
//  Operation.swift
//
//  Created by fahad c h on 01/04/18.
//  Copyright © 2018 FahadHyder. All rights reserved.
//

import Foundation

open class JSONOperation<Output>: OperationProtocol  where Output: Codable {
    
    typealias T = Output

    var request: RequestProtocol?
    
    public init() {
        
    }
    
    func execute(in service: ServiceProtocol, completion: @escaping (_ response: T?, _ resultType: Response.ResultType) -> Void) {
        guard let request = self.request else {
            return
        }
        service.execute(request: request) { (response) in
            switch response.type {
            case .error, .success:
                if let output = JSONOperation.decodeModel(responseData: response.data) {
                    completion(output, response.type)
                } else {
                    completion(nil, response.type)
                }
            case .noResponse:
                completion(nil, response.type)
            }
        }
    }
    
    static func decodeModel(responseData: Data?) -> Output? {
        guard let data = responseData else {
            print("API Error: No data")
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let output = try decoder.decode(T.self, from: data)
            return output
        } catch {
            print("API Error: Data is not decodable")
        }
        return nil
    }
}
