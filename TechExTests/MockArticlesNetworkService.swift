//
//  MockArticlesService.swift
//  TechExTests
//
//  Created by macbook on 20/12/2025.
//

import Foundation
@testable import TechEx

final class MockNetworkService: NetworkServiceProtocol {
    var resultToReturn: NetworkResult<NYTimesBaseModel>?

    func sendRequest<W: Requestable>(request: W) async -> NetworkResult<W.ResponseType> {
        // Force the mock result to match the expected ResponseType
        return resultToReturn as! NetworkResult<W.ResponseType>
    }
}

