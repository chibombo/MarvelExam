//
//  Character.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 23/03/21.
//

import Foundation

struct Character: Decodable {
    struct Thumbnail: Decodable {
        let path: String
        let fileType: String
        // swiftlint:disable nesting
        enum CodingKeys: String, CodingKey {
            case path
            case fileType = "extension"
        }
    }
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}
