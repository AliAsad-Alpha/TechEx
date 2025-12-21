//
//  ArticleHomeViewModel.swift
//  TechEx
//
//  Created by macbook on 18/12/2025.
//

import Foundation
import OSLog

final class NetworkManager: NetworkServiceProtocol {

    let apiLogger = Logger(subsystem: "com.gof.TechEx", category: "API")

    func sendRequest<W: Requestable>(request: W) async -> NetworkResult<W.ResponseType> {
        // Build URL
        let url = request.baseUrl.appending(path: request.endpoint)
        apiLogger.debug("API URL: \(url)")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        // Set headers
        if let headers = request.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        // Encode parameters based on HTTP method
        switch request.method {
        case .get:
            // For GET requests, append query parameters to the URL
            if let params = request.parameters,
               var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                components.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                if let finalURL = components.url {
                    urlRequest.url = finalURL
                }
            }

        case .post:
            // For POST requests, send parameters in the HTTP body
            if let params = request.parameters {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }

        }


        // Send request
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.unknown(NSError(domain: "NoResponse", code: 0)))
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                return .failure(.serverError(httpResponse.statusCode))
            }

            // Decode response
            do {
                let decoded = try JSONDecoder().decode(W.ResponseType.self, from: data)
                //Add check in case of sandbox should log the data
                if let jsonString = String(data: data, encoding: .utf8) {
                    apiLogger.debug("API Response Body: \(jsonString)")
                }
                return .success(decoded)
            } catch {
                return .failure(.decodingError)
            }

        } catch {
            return .failure(.unknown(error))
        }
    }
}
