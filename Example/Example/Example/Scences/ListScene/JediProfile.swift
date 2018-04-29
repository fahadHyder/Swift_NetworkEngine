//
//  JediProfile.swift
//
//  Created by fahad c h on 01/04/18.
//  Copyright © 2018 FahadHyder. All rights reserved.
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
