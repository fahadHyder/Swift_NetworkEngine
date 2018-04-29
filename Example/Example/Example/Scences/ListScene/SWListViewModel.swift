//
//  SWListViewModel.swift
//
//  Created by fahad c h on 01/04/18.
//  Copyright © 2018 FahadHyder. All rights reserved.
//

import Foundation

class SWListViewModel {
    public var jdProfiles: [JediProfile]?
    public func getStarWarsCharacters(completion: @escaping (Bool) -> Void) {
        //You could configure your own service instance.
        let service = Service(configuration: ServiceConfig()!)
        StartWarsOperation().execute(in: service) { [weak self] (startWarsResponse, resultType) in
            self?.jdProfiles = startWarsResponse?.characters
            DispatchQueue.main.async {
                completion(true)
            }
        }
    }
}
