//
//  CharacterListInteractorTest.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 25/03/21.
//

import XCTest
@testable import MarvelExamDev

class CharacterListInteractorTest: XCTestCase {
    
    var interactor: CharactersListInteractor!
    var spy: CharactersListPresentationLogicSpy!
    
    override func setUpWithError() throws {
        spy = CharactersListPresentationLogicSpy()
        interactor = CharactersListInteractor(presenter: spy, repository: MarvelCharactersRepositoryMock())
    }

    override func tearDownWithError() throws {
        interactor = nil
        spy = nil
    }

    func testFetch_whenRepository_returnCharacters() throws {

        let expectation = self.expectation(description: "FetchCharacters")
        expectation.isInverted = true

        interactor.fetchCharacters()
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertTrue(!spy.characters.isEmpty, "Character empty")
    }

    func testFetch_whenRepository_returnError() throws {
        interactor.repository = MarvelCharactersRepositoryErrorMock()

        interactor.fetchCharacters()

        XCTAssertTrue(spy.isAlertPresented, "Alert not presented")
    }
}
