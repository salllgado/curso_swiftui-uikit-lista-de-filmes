//
//  Bundle+Extensions.swift
//  MovieList
//
//  Created by Chrystian Salgado on 01/02/26.
//

import Foundation

extension Bundle {
    var secrets: [String: Any]? {
        guard let url = url(forResource: "Secrets", withExtension: "plist") else { return nil }
        return NSDictionary(contentsOf: url) as? [String: Any]
    }
}
