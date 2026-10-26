//
//  APIManager.swift
//  LearnForInterview
//
//  Created by Preeteesh Remalli on 27/10/26.
//

import Foundation

public final class APIManager: @unchecked Sendable {
    public static let shared = APIManager()
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    public init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    public func request<T: Codable>(resource: Resource<T>) async throws -> T {
        guard let url = resource.url else {
            throw APIError.urlError
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = resource.method.rawValue
        urlRequest.httpBody = resource.body
        
        resource.headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await session.data(for: urlRequest)
        } catch {
            throw APIError.networkError(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidError
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            let message = String(data: data, encoding: .utf8)
            throw APIError.serverError(statusCode: httpResponse.statusCode, message: message)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
