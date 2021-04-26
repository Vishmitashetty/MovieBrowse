//
//  MovieSearchTableViewControllerTest.swift
//  MovieAppTests
//
//  Created by Vishmita Shetty on 26/04/21.
//

import XCTest
@testable import MovieApp

class MovieSearchTableViewControllerTest: XCTestCase {

    var controller: MovieSearchTableViewController!
    var movieList: MovieListResponse?
    
    override func setUpWithError() throws {
        let mockMovieSearchRepo = MockMovieSearchRepository.shared
        let storyBoard = UIStoryboard(name: "MovieList", bundle: nil)
        controller = (storyBoard.instantiateViewController(withIdentifier: "MovieSearchTableViewController") as! MovieSearchTableViewController)
        controller.movieSearchRepository = mockMovieSearchRepo
        controller.getMovieBySearch(query: "a")
        controller.loadViewIfNeeded()
        movieList = mockMovieSearchRepo.getMovieSearch()
    }
    
    func test_noOfSection_InMovieSearchTableVC() {
        //Arrange
        let noOfSections = controller.numberOfSections(in: controller.tableView)
        //Assert
        XCTAssertEqual(noOfSections, 2)
    }
    
    func test_noOfRows_InSection0_InMovieSearchTableVC() {
        //Arrange
        let noOfRows = controller.tableView(controller.tableView, numberOfRowsInSection: 0)
        //Assert
        XCTAssertEqual(noOfRows, 20)
    }
    
    func test_movieSearchLabelAssignment_InMovieSearchTableViewCell() {
        //Arrange
        let movieSearchLabelText = getMovieLMovieSearchTableViewCell().movieSearchLabel.text
        let movieSearchText = movieList?.results?.first?.title ?? ""
        //Assert
        XCTAssertEqual(movieSearchLabelText, movieSearchText)
    }

    override func tearDownWithError() throws {
        controller = nil
        movieList = nil
    }
}

extension MovieSearchTableViewControllerTest {
    func getMovieLMovieSearchTableViewCell() -> MovieSearchTableViewCell {
        
       return controller.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MovieSearchTableViewCell
    }
}
