//
//  CharacterDetailPresenterTest.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 26/03/21.
//

import XCTest
@testable import MarvelExamDev

class CharacterDetailPresenterTest: XCTestCase {

    var presenter: CharacterDetailPresenter!
    var spy: CharacterDetailDisplayLogicSpy!

    override func setUpWithError() throws {
        spy = CharacterDetailDisplayLogicSpy()
        presenter = CharacterDetailPresenter(viewController: spy)
    }

    override func tearDownWithError() throws {
        presenter = nil
        spy = nil
    }

    func testPresenter_whenCharacter_isDisplayed() throws {
        if let data = UtilitiesWorker.jsonToData(name: "CharacterDetailResponse"),
           let response = Utilities.convertDataToDecodable(decodable: CharacterDetailResponse.self, data: data) {
            
            presenter.presentDetail(response: response)
            
            XCTAssertTrue(spy.isDetailDisplayed, "Detail not Displayed")
            
        } else {
            XCTAssert(false, "CharacterDetailResponse Error")
        }
    }
    
    func testPresenter_whenAlert_isDisplayed() throws {
        presenter.presentAlert(error: NetworkingError.unknow)
        
        XCTAssertTrue(spy.isAlertDisplayed, "Allert not Displayed")
    }
}
