//
//  DuckGoResult.swift
//  DuckGoTest
//
//  Created by Raphael Araújo on 2018-05-15.
//  Copyright © 2018 Raphael Araújo. All rights reserved.
//

import Foundation

struct DuckGoResultItem: Codable {
    let name: String?
    let icon: Icon?
    let firstURL: String?
    let text: String?
    let topics: [DuckGoResultItem]?
    
    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case firstURL = "FirstURL"
        case text = "Text"
        case topics = "Topics"
        case name = "Name"
    }
}

struct DuckGoResult: Codable {
    let results: [DuckGoResultItem]?
    let relatedTopics: [DuckGoResultItem]?
    
    enum CodingKeys: String, CodingKey {
        case results = "Results"
        case relatedTopics = "RelatedTopics"
    }
}
