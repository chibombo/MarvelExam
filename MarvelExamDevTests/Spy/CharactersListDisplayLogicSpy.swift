//
//  CharactersListDisplayLogicSpy.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 25/03/21.
//

import Foundation
@testable import MarvelExamDev

class CharactersListDisplayLogicSpy: CharactersListDisplayLogic {

    var isAlertPresented: Bool = false
    var characters: [Character] = []

    func displayCharacters(characters: [Character]) {
        self.characters = characters
    }

    func displayAlert(title: String, message: String) {
        isAlertPresented = true
    }
}
