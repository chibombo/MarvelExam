//
//  CharacterDetailPresentationLogicSpy.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 26/03/21.
//

import Foundation
@testable import MarvelExamDev

class CharacterDetailPresentationLogicSpy: CharacterDetailPresentationLogic {

    var isDetailPresented: Bool = false
    var isAlertPresented: Bool = false

    func presentDetail(response: CharacterDetailResponse) {
        isDetailPresented = true
    }

    func presentAlert(error: Error) {
        isAlertPresented = true
    }
}
