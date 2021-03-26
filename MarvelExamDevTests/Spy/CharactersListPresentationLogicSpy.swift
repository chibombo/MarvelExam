//
//  CharactersListPresentationLogicSpy.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 25/03/21.
//

import Foundation
@testable import MarvelExamDev

class CharactersListPresentationLogicSpy: CharactersListPresentationLogic {
    
    var characters: [Character] = []
    var isAlertPresented: Bool = false
    
    func presentCharactersList(response: FetchCharactersResponse) {
        characters = response.data.results
    }
    
    func presentAlert(error: Error) {
        isAlertPresented = true
    }
    
}
