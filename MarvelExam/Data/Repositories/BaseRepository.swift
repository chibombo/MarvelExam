//
//  BaseRepository.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 24/03/21.
//

import Foundation

class BaseRepository {
    let urlSession: URLSessionWorker
    let publicKey: String
    let privateKey: String

    init() {
        urlSession = URLSessionWorker.shared
        publicKey = "474693496a5bf73de481d363dd37576a"
        privateKey = "82b77319c60872c8f118c303324567a1dc3e0eaa"
    }

}
