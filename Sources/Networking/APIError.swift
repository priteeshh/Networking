//
//  APIError.swift
//  LearnForInterview
//
//  Created by Preeteesh Remalli on 27/10/26.
//

import Foundation

enum APIError: Error, LocalizedError {
    case urlError
    case invalidError
    case decodingError(Error)
    case serverError(statusCode: Int, message: String?)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .urlError:
            "Invalid URL"
        case .invalidError:
            "Invalid Server Error"
        case .decodingError(let error):
            "Failed to decode response: \(error.localizedDescription)"
        case .serverError(let statusCode, let message):
            message ?? "Server error: HTTP \(statusCode)."
        case .networkError(let error):
            "Network error: \(error.localizedDescription)"
        }
    }
}
