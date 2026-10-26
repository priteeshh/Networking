//
//  Resource.swift
//  LearnForInterview
//
//  Created by Preeteesh Remalli on 27/10/26.
//

import Foundation

public struct Resource<T: Codable> {
    let url: URL?
    var method: HTTPMethod = .get
    var header: [String: String] = [
        "Accept": "application/json"
    ]
    var body: Data? = nil
}
