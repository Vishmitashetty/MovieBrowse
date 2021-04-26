//
//  EnvironmentTest.swift
//  MovieAppTests
//
//  Created by Vishmita Shetty on 26/04/21.
//

import XCTest
@testable import MovieApp

class EnvironmentTest: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
    }
    
    func test_endPointUrl_ForDev() {
        //Arrange
        let endPoint = Environment.serverEndPoint
        //Assert
        XCTAssertEqual(endPoint, "api.themoviedb.org")
    }
    
    func test_apiVersion_ForDev() {
        //Arrange
        let apiVersion = Environment.apiVersion
        //Assert
        XCTAssertEqual(apiVersion, "3")
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
}
