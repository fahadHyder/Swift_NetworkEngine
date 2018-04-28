//
//  JediProfile.swift
//  SqliteDemo
//
//  Created by fahad c h on 25/12/17.
//  Copyright © 2017 Litmus7. All rights reserved.
//

import Foundation
struct JediProfile:Codable {
    let name : String
    let gender: String
    let eyeColor: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case gender
        case eyeColor = "eye_color"
    }
}
