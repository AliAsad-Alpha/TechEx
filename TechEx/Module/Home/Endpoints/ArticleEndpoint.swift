//
//  ArticleServices.swift
//  TechEx
//
//  Created by macbook on 20/12/2025.
//

import Foundation
import Combine

struct ArticleEndpoint: Requestable {
    typealias ResponseType = NYTimesBaseModel
    
    var baseUrl: URL {
        URL(string: "https://api.nytimes.com")!
    }
    
    var endpoint: String {
        "svc/mostpopular/v2/mostviewed/all-sections/7.json"
    }
    
    var method: NetworkMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        ["api-key" : "GJAsA66EvXMH3WUYFjOQTQrz6bIKTmuVdTsdexQYWcoFx3gS"]
    }
    
    var headers: [String : String]? {
        nil
    }
}
