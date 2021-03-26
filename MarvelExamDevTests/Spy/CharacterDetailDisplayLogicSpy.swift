//
//  CharacterDetailDisplayLogicSpy.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 26/03/21.
//

import Foundation
@testable import MarvelExamDev

class CharacterDetailDisplayLogicSpy: CharacterDetailDisplayLogic {
    
    var isDetailDisplayed: Bool = false
    var isAlertDisplayed: Bool = false

    func displayDetail(detail: Character) {
        isDetailDisplayed = true
        
    }
    
    func displayAlert(title: String, message: String) {
        isAlertDisplayed = true
    }
    
    
}
