//
//  CharacterDetailResponse.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 24/03/21.
//

import Foundation

struct CharacterDetailResponse: Decodable {
    struct Information: Decodable {
        let count: Int
        let results: [Character]
    }
    let code: Int
    let data: Information
}
