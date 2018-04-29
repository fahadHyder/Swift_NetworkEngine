//
//  StarWarsCharacterResponseModel.swift
//
//  Created by fahad c h on 01/04/18.
//  Copyright © 2018 FahadHyder. All rights reserved.
//

import Foundation
public struct StarWarsCharacterResponseModel:Codable {
    let next: String
    let characters: [JediProfile]
    
    private enum CodingKeys: String,CodingKey {
        case next
        case characters = "results"
    }
}
