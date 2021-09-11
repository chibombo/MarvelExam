//
//  MarvelExamUITests.swift
//  MarvelExamUITests
//
//  Created by Luis Genaro Arvizu Vega on 22/03/21.
//

import XCTest

class UITestHappyPath: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    func testHappyPath() throws {
        let app = XCUIApplication()
        app.launch()

        let tableView = app.tables.element
        XCTAssert(tableView.exists)

        let row = tableView.cells.firstMatch
        XCTAssert(row.exists)

        row.tap()

        let lblName = app.staticTexts["A.I.M."]
        if lblName.waitForExistence(timeout: 5) {
            XCTAssert(lblName.exists)
        }

    }
}
