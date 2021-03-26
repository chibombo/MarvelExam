//
//  CharacterDetailBusinessLogicSpy.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 26/03/21.
//

import Foundation
@testable import MarvelExamDev

class CharacterDetailBusinessLogicSpy: CharacterDetailBusinessLogic {
    
    var isCharacterDetailGotten: Bool = false

    func getCharacterDetail(request: CharacterDetailRequest) {
        isCharacterDetailGotten = true
    }

}
