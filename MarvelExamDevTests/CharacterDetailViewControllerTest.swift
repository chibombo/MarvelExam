//
//  CharacterDetailViewController.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 26/03/21.
//

import XCTest
@testable import MarvelExamDev

class CharacterDetailViewControllerTest: XCTestCase {

    var viewController: CharacterDetailViewController!
    
    override func setUpWithError() throws {
        viewController = CharacterDetailViewController()
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testViewController_whenDetails_isGotten() throws {
        let request = CharacterDetailRequest(id: 123)
        let expectation = self.expectation(description: "GetDetail")
        expectation.isInverted = true

        viewController.interactor?.getCharacterDetail(request: request)
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssert(viewController.lblName.text == "A.I.M.", "Get detail failed")
    }
}
