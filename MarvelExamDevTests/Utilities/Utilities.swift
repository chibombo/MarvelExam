//
//  Utilities.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 25/03/21.
//

import Foundation
@testable import MarvelExamDev

class Utilities {
    
    static func convertDataToDecodable<T: Decodable>(decodable: T.Type, data: Data) -> T? {
        do {
            return try JSONDecoder().decode(decodable, from: data)
        } catch {
            return nil
        }
    }
}
