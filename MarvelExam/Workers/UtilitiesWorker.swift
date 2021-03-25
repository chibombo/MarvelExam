//
//  UtilitiesWorker.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 24/03/21.
//

import Foundation

class UtilitiesWorker {
    static func jsonToData(name: String) -> Data? {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {return nil}
        do {
            let url: URL = URL(fileURLWithPath: path)
            let data: Data = try Data(contentsOf: url, options: .mappedIfSafe)
            return data
        } catch {
            return nil
        }
    }
}
