//
//  ContentView.swift
//  TechEx
//
//  Created by macbook on 18/12/2025.
//

import Foundation
struct ArticlesResult : Codable, Hashable, Identifiable {
    
    public init(uri: String? = nil, url: String? = nil, id: Int? = nil, asset_id: Int? = nil, source: String? = nil, published_date: String? = nil, updated: String? = nil, section: String? = nil, subsection: String? = nil, nytdsection: String? = nil, column: String? = nil, byline: String? = nil, type: String? = nil, title: String? = nil, abstract: String? = nil, des_facet: [String]? = nil, org_facet: [String]? = nil, per_facet: [String]? = nil, geo_facet: [String]? = nil, media: [ArticleMedia]? = nil, eta_id: Int? = nil) {
        self.uri = uri
        self.url = url
        self.id = id
        self.asset_id = asset_id
        self.source = source
        self.published_date = published_date
        self.updated = updated
        self.section = section
        self.subsection = subsection
        self.nytdsection = nytdsection
        self.column = column
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.des_facet = des_facet
        self.org_facet = org_facet
        self.per_facet = per_facet
        self.geo_facet = geo_facet
        self.media = media
        self.eta_id = eta_id
        self.adx_keywords = ""
    }
    
	let uri : String?
	let url : String?
	let id : Int?
	let asset_id : Int?
	let source : String?
	let published_date : String?
	let updated : String?
	let section : String?
	let subsection : String?
	let nytdsection : String?
	let column : String?
	let byline : String?
	let type : String?
	let title : String?
	let abstract : String?
	let des_facet : [String]?
	let org_facet : [String]?
	let per_facet : [String]?
	let geo_facet : [String]?
    let adx_keywords: String?
	let media : [ArticleMedia]?
	let eta_id : Int?
    
    func imageURL(quality: ImageQuality) -> URL? { // Assuming the photo
        switch quality {
        case .low:
            URL(string: self.media?.first?.articleMediaMetaData?.filter { $0.format == "Standard Thumbnail" }.first?.url ?? "")
        case .medium:
            URL(string: self.media?.first?.articleMediaMetaData?.filter { $0.format == "Standard Thumbnail" }.first?.url ?? "")
        case .high:
            URL(string: self.media?.first?.articleMediaMetaData?.filter { $0.format == "mediumThreeByTwo440" }.first?.url ?? "")
        }
    }
}
