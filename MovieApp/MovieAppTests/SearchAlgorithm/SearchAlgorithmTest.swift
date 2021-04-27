//
//  SearchAlgorithmTest.swift
//  MovieAppTests
//
//  Created by Vishmita Shetty on 26/04/21.
//

import XCTest
@testable import MovieApp

class SearchAlgorithmTest: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
    }
    
    func test_filterMovie_BasedOnCharacter_NotInBetweenString() {
        //Arrange
        let array = ["R​alph Breaks The Internet", "Bohemian ​R​hapsody", "The Grinch", "KGF", "Spider-Man: Into the Spider-Verse", "Maa​r​i"]
        let resultArray = ["R​alph Breaks The Internet", "Bohemian ​R​hapsody"]
        let filterArray = filterMovie(array: array, pattern: "r")
        //Assert
        XCTAssertEqual(resultArray, filterArray)
    }
    
    func test_filterMovie_BasedOnString_InAnySequence() {
        //Arrange
        let array = ["Dilwale Dulhania Le Jaayenge", "Dulhania Le Jaayenge", "Le Jaayenge", "Dulhania Le Jaayenge Dilwale", "Spider-Man: Into the Spider-Verse", "Le Jaayenge Dilwale​"]
        let resultArray = ["Dilwale Dulhania Le Jaayenge", "Dulhania Le Jaayenge", "Le Jaayenge", "Dulhania Le Jaayenge Dilwale", "Le Jaayenge Dilwale​"]
        let filterArray = filterMovie(array: array, pattern: "Le Jaayenge Dilwale​")
        //Assert
        XCTAssertEqual(resultArray, filterArray)
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
}

//MARK: - Filter movie logic
extension SearchAlgorithmTest {
    
    func filterMovie(array: [String], pattern: String) -> [String] {
        
        var movieList: [String] = []
        array.forEach({ (movie) in
            if movie.searchString(patternValue: pattern) {
                movieList.append(movie)
            }
        })
        return movieList
    }
}
