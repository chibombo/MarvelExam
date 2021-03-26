//
//  CharacterListPresenterTest.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 25/03/21.
//

import XCTest
@testable import MarvelExamDev

class CharacterListPresenterTest: XCTestCase {

    var presenter: CharactersListPresenter!
    var spy: CharactersListDisplayLogicSpy!
    
    override func setUpWithError() throws {
        spy = CharactersListDisplayLogicSpy()
        presenter = CharactersListPresenter(viewController: spy)
    }

    override func tearDownWithError() throws {
        presenter = nil
        spy = nil
    }

    func testPresenter_whenError_isPresented() throws {
        let error = NetworkingError.timeout

        presenter.presentAlert(error: error)

        XCTAssertTrue(spy.isAlertPresented, "Alert not presented")
    }

    func testPresenter_whenResponse_isCorrect() throws {
        if let data = UtilitiesWorker.jsonToData(name: "FetchCharactersResponse"),
           let response = Utilities.convertDataToDecodable(decodable: FetchCharactersResponse.self, data: data) {
            presenter.presentCharactersList(response: response)
            XCTAssertTrue(!spy.characters.isEmpty, "Characters Array Empty")
        } else {
            XCTAssertTrue(false, "Utilities failed")
        }
    }
}
