//
//  ArticleHomeViewModel.swift
//  TechEx
//
//  Created by macbook on 18/12/2025.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case serverError(Int)
    case unknown(Error)
}

protocol NetworkServiceProtocol {
    func sendRequest<W: Requestable>(request: W) async ->  NetworkResult<W.ResponseType>
}

enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Requestable {
    associatedtype ResponseType: Decodable

    var baseUrl: URL { get }
    var endpoint: String { get }
    var method: NetworkMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}



