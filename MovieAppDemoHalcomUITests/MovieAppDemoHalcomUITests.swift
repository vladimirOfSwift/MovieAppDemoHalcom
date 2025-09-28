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
    
    func testTabNavigation() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.tabBars.buttons["Movies"].exists)
        XCTAssertTrue(app.tabBars.buttons["Movies"].isSelected)
        
        let favoritesTab = app.tabBars.buttons["Favorites"]
        XCTAssertTrue(favoritesTab.exists)
        favoritesTab.tap()
        
        XCTAssertTrue(favoritesTab.isSelected)
    }
    
    func testSearchBarExists() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchField = app.searchFields["Search by title"]
        XCTAssertTrue(searchField.exists, "Search bar should exist on the Movies tab")
    }
  
}
