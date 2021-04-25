//
//  MovieListViewControllerTest.swift
//  MovieAppTests
//
//  Created by Vishmita Shetty on 22/04/21.
//

import XCTest
@testable import MovieApp

class MovieListViewControllerTest: XCTestCase {

    var controller: MovieListViewController!
    var movieList: MovieListResponse?
    
    override func setUpWithError() throws {
        super.setUp()
        let mockRepo = MockMovieListRepository.shared
        let storyBoard = UIStoryboard(name: "MovieList", bundle: nil)
        controller = (storyBoard.instantiateViewController(withIdentifier: "movieList") as! MovieListViewController)
        controller.movieListRepository = mockRepo
        controller.loadViewIfNeeded()
        controller.getNowPlaying(pageNo: 1)
        movieList = mockRepo.getMovieList()
    }
    
    func test_movieList_noOfRows_InCollectionView() {
        //Arrange
        let movieListCount = movieList?.results?.count ?? 0
        //Assert
        XCTAssertEqual(movieListCount, 20)
    }
    
    func test_movieListCell_movieTitle() {
        //Arrange
        let movieListTitle = getMovieListCollectionViewCell().movieTitle.text
        let movieObj = movieList?.results?.first ?? nil
        //Assert
        XCTAssertEqual(movieObj?.title, movieListTitle, "Movie title assignment is correct")
    }
    
    func test_movieListCell_movieReleaseDate() {
        //Arrange
        let movieReleaseDate = getMovieListCollectionViewCell().movieReleaseDate.text
        let movieObj = movieList?.results?.first ?? nil
        //Assert
        XCTAssertEqual(movieObj?.releaseDate, movieReleaseDate, "Movie release date assignment is correct")
    }

    override func tearDownWithError() throws {
        super.tearDown()
        controller = nil
        movieList = nil
    }

}

extension MovieListViewControllerTest {
    func getMovieListCollectionViewCell() -> MovieListCollectionViewCell {
        return controller.movieCollectionDataSource.collectionView(controller.movieCollectionView, cellForItemAt: IndexPath(row: 0, section: 0))
            as! MovieListCollectionViewCell
    }
}
