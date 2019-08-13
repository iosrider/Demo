//
//  HsbcTestTests.swift
//  HsbcTestTests
//
//  Created by Ankit Vyas on 10/08/19.
//  Copyright © 2019 Ankit Vyas. All rights reserved.
//

import XCTest
import KIF

@testable import HsbcTest

class HsbcTestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
extension XCTestCase {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}


class LoginTests : KIFTestCase {
    
  
    func addLoginCredentials(userName: String, password: String) {
        tester().enterText(userName, intoViewWithAccessibilityLabel: "Login - Username")
        tester().enterText(password, intoViewWithAccessibilityLabel: "Login - Password")
    }
    
    func clearOutUsernameAndPasswordFields() {
        tester().clearTextFromView(withAccessibilityLabel: "Login - Username")
        tester().clearTextFromView(withAccessibilityLabel: "Login - Password")
    }
    func tapButton(buttonName: String) {
        tester().tapView(withAccessibilityLabel: buttonName)
    }
    func expectToSeeView(text: String) {
        tester().waitForView(withAccessibilityLabel: text)
    }
    
    // MARK: - Success Login
    func testUsernameAndPassword() {
        expectToSeeView(text: "Login - Username")
        clearOutUsernameAndPasswordFields()
        addLoginCredentials(userName: "hsbc", password: "123456")
        tapButton(buttonName: "LoginButton")
        expectToSeeView(text: "Book-View")
    }

    
  
}
