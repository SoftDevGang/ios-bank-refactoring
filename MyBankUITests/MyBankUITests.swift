//
//  MyBankUITests.swift
//  MyBankUITests
//
//  Created by Bastien DAVID on 04/10/2018.
//  Copyright © 2018 Soft Dev Gang. All rights reserved.
//

import XCTest

class MyBankUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.pickerWheels["current account"].tap()
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        app.pickerWheels["mom"].tap()
        nextButton.tap()
        app.textFields["amount"].tap()
        app.textFields["amount"].typeText("45\n")
        nextButton.tap()
        XCTAssertEqual(app.staticTexts["summary"].label, "Transfert from current account to mom of 45")
    }

    func testErrorMessage() {
        let app = XCUIApplication()
        app.pickerWheels["current account"].tap()
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        app.pickerWheels["mom"].tap()
        nextButton.tap()
        app.textFields["amount"].tap()
        app.textFields["amount"].typeText("XXX\n")
        nextButton.tap()
        XCTAssertEqual(app.staticTexts["errorMessage"].label, "Amount must be a number")
    }}
