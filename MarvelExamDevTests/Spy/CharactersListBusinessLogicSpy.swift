//
//  CharactersListBusinessLogicSpy.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 25/03/21.
//

import Foundation
@testable import MarvelExamDev

class CharactersListBusinessLogicSpy: CharactersListBusinessLogic {

    var isCharactersFetched: Bool = false

    func fetchCharacters() {
        isCharactersFetched = true
    }
}
