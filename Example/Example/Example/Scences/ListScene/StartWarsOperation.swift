//
//  StartWarsOperation.swift
//
//  Created by fahad c h on 01/04/18.
//  Copyright © 2018 FahadHyder. All rights reserved.
//

import Foundation

// For demo purpose
public class StartWarsOperation: JSONOperation<StarWarsCharacterResponseModel> {
    public override init() {
        super.init()
        self.request = Request(method: .get, endpoint: "/people", params: nil, fields: nil, body: nil)
    }
}
