//
//  File.swift
//  DuckGoTest
//
//  Created by Raphael Araújo on 2018-05-16.
//  Copyright © 2018 Raphael Araújo. All rights reserved.
//

import Foundation

struct Icon: Codable {
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "URL"
    }
}
