//
//  MarvelExamDevTests.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 25/03/21.
//

import XCTest
@testable import MarvelExamDev

class CharacterListViewControllerTest: XCTestCase {

    var viewController: CharactersListViewController!

    override func setUpWithError() throws {
        viewController = CharactersListViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
    }

    func testViewController_whenCharacters_areNotEmpty() throws {

        var cellCount: Int = 0
        var charactersCount: Int = 0

        viewController.interactor?.fetchCharacters()
        let expectation = self.expectation(description: "FetchCharacters")
        expectation.isInverted = true
        waitForExpectations(timeout: 5, handler: nil)

        charactersCount = viewController.characters.count
        cellCount = viewController.tableView.numberOfRows(inSection: 0)

        XCTAssertTrue(charactersCount != 0, "The array is Empty")
        XCTAssertTrue(cellCount == charactersCount, "cellCount and charactersCount different")
    }
}
