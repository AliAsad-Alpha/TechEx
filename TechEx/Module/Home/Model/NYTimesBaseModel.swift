//
//  ContentView.swift
//  TechEx
//
//  Created by macbook on 18/12/2025.
//

import Foundation
struct NYTimesBaseModel : Codable {
    public init(status: String? = nil, copyright: String? = nil, num_results: Int? = nil, results: [ArticlesResult] = []) {
        self.status = status
        self.copyright = copyright
        self.num_results = num_results
        self.results = results
    }
    
	let status : String?
	let copyright : String?
	let num_results : Int?
	let results : [ArticlesResult]
}
