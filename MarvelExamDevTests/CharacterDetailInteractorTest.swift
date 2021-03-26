//
//  CharacterDetailInteractorTest.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 26/03/21.
//

import XCTest
@testable import MarvelExamDev

class CharacterDetailInteractorTest: XCTestCase {

    var interactor: CharacterDetailInteractor!
    var spy: CharacterDetailPresentationLogicSpy!
    
    override func setUpWithError() throws {
        spy = CharacterDetailPresentationLogicSpy()
        interactor = CharacterDetailInteractor(presenter: spy, repository: MarvelCharactersRepositoryMock())
    }

    override func tearDownWithError() throws {
        interactor = nil
        spy = nil
    }

    func testInteractor_whenCharacter_isGotten() throws {

        let request: CharacterDetailRequest = CharacterDetailRequest(id: 123)
        
        interactor.getCharacterDetail(request: request)
        
        XCTAssertTrue(spy.isDetailPresented, "Character not gotten")
    }
    
    func testInteractor_whenCharacter_notGotten() throws {
        let request: CharacterDetailRequest = CharacterDetailRequest(id: 123)

        interactor.repository = MarvelCharactersRepositoryErrorMock()
        interactor.getCharacterDetail(request: request)

        XCTAssertTrue(spy.isAlertPresented, "Alert not Presented")
    }
}
