//
//  ContentView.swift
//  TechEx
//
//  Created by macbook on 18/12/2025.
//

import Foundation
struct ArticleMedia : Codable, Hashable {
	let type : String?
	let subtype : String?
	let caption : String?
	let copyright : String?
	let approved_for_syndication : Int?
	let articleMediaMetaData : [ArticleMediaMetadata]?
    
    
    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approved_for_syndication
        case articleMediaMetaData = "media-metadata"
    }
}
