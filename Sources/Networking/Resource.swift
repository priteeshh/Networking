//
//  Resource.swift
//  LearnForInterview
//
//  Created by Preeteesh Remalli on 27/10/26.
//

import Foundation

public struct Resource<T: Decodable> {
    public let url: URL
    public var method: HTTPMethod
    public var headers: [String: String]
    public var body: Data?

    public init(
        url: URL,
        method: HTTPMethod = .get,
        headers: [String: String] = ["Accept": "application/json"],
        body: Data? = nil
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }
}
