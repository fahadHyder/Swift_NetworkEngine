//
//  SWListViewModel.swift
//  SqliteDemo
//
//  Created by fahad c h on 25/12/17.
//  Copyright © 2017 Litmus7. All rights reserved.
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
