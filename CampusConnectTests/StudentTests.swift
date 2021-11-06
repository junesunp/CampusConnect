//
//  StudentTests.swift
//  CampusConnectTests
//
//  Created by Andy Park on 11/5/21.
//

import XCTest
@testable import CampusConnect

class StudentTests: XCTestCase {

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
      let wonho = Student(id: "123", Email:"wonho@gmail.com", First:"Wonho", Last:"Kang", Grad:"2022", Major:"ECE", Phone:"412-512-8888", School:"CMU", Password:"secret", Groups: [])

      XCTAssertNotNil(wonho)
      XCTAssertEqual(wonho.First, "Wonho")
      XCTAssertEqual(wonho.Last, "Kang")
    }

}
