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
        continueAfterFailure = false

        XCUIApplication().launch()

    }

    override func tearDown() {
    }

    
    
    func testValidationBalanceMustBeGreaterThanAmount() {
        let app = XCUIApplication()
        app.pickerWheels.element.adjust(toPickerWheelValue: "stocks")
        app.pickerWheels["stocks"].tap()
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        app.pickerWheels["mom"].tap()
        nextButton.tap()
        app.textFields["amount"].tap()
        app.textFields["amount"].typeText("301\n")
        nextButton.tap()
        XCTAssertEqual(app.staticTexts["errorMessage"].label, "Amount cannot be greater than 300")
    }
    
    func testValidationBalanceMustBeGreaterThanAmountAndAllowedCredit() {
        let app = XCUIApplication()
        app.pickerWheels["current account"].tap()
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        app.pickerWheels["mom"].tap()
        nextButton.tap()
        app.textFields["amount"].tap()
        app.textFields["amount"].typeText("351\n")
        nextButton.tap()
        XCTAssertEqual(app.staticTexts["errorMessage"].label, "Amount cannot be greater than 350")
    }

    func testTransferWorks() {
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

    func testValidationAmountMustBeNumber() {
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
    }
    
    func testValidationAmountMustBeGreaterThan0() {
        let app = XCUIApplication()
        app.pickerWheels["current account"].tap()
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        app.pickerWheels["mom"].tap()
        nextButton.tap()
        app.textFields["amount"].tap()
        app.textFields["amount"].typeText("-1\n")
        nextButton.tap()
        XCTAssertEqual(app.staticTexts["errorMessage"].label, "Amount must be greater than zero")
    }
    
}
