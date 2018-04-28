//
//  StarWarsCharacterResponseModel.swift
//  SqliteDemo
//
//  Created by fahad c h on 25/12/17.
//  Copyright © 2017 Litmus7. All rights reserved.
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
