//
//  RecruiterTests.swift
//  CampusConnectTests
//
//  Created by Andy Park on 11/5/21.
//

import XCTest
@testable import CampusConnect

class RecruiterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      super.setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      super.tearDown()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      let jack = Recruiter(id: "abc", Email:"jack@gmail.com", First:"Jack", Last:"Fuller", Phone:"412-512-9922", Company:"HL", Position:"Analyst", Password:"secret")

      XCTAssertNotNil(jack)
      XCTAssertEqual(jack.First, "Jack")
      XCTAssertEqual(jack.Last, "Fuller")
    }

}
