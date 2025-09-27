//
//  MovieAppDemoHalcomUITests.swift
//  MovieAppDemoHalcomUITests
//
//  Created by Vladimir Savic on 24. 9. 2025..
//

import XCTest

final class MovieAppDemoHalcomUITests: XCTestCase {

    override func setUpWithError() throws {
        
        continueAfterFailure = false

    }

    func testErrorAlertAppears() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-UITestErrorCase"]
        app.launch()
        
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "Error alert should appear")
        
        XCTAssertTrue(alert.buttons["Retry"].exists)
        XCTAssert(alert.buttons["Cancel"].exists)
    }
    
    func testMovieListLoads() throws {
        let app = XCUIApplication()
        app.launch()
        
        let firstMovieCell = app.tables.cells.firstMatch
        XCTAssertTrue(firstMovieCell.waitForExistence(timeout: 5), "Movie list table view should not be empty")
    }
}
