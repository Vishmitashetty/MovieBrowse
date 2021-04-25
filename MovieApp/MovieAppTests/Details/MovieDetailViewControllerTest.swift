//
//  MovieDetailViewControllerTest.swift
//  MovieAppTests
//
//  Created by Vishmita Shetty on 25/04/21.
//

import XCTest
@testable import MovieApp

class MovieDetailViewControllerTest: XCTestCase {

    var controller: MovieDetailViewController!
    var similarMovieCollectionView: SimilarMovieCollectionView!
    
    var synoypsisResponse: SynoypsisResponse?
    var movieCastResponse: MovieCastResponse?
    var similarMovieResponse: SimilarMovieResponse?
    
    override func setUpWithError() throws {
        super.setUp()
        let synopsisMockRepo = MockGetSynoypsisRepository.shared
        let similarMockRepo = MockSimilarMovieRepository.shared
        let movieCastMockRepo = MockMovieCastRepository.shared
        let storyBoard = UIStoryboard(name: "MovieDetail", bundle: nil)
        controller = (storyBoard.instantiateViewController(withIdentifier: "movieDetailViewController") as! MovieDetailViewController)
        controller.synoypsisRepository = synopsisMockRepo
        controller.movieCastRepository = movieCastMockRepo
        controller.similarMovieRepository = similarMockRepo
        controller.loadViewIfNeeded()
        
        synoypsisResponse = synopsisMockRepo.getSynoypsisResponse()
        movieCastResponse = movieCastMockRepo.getMovieCastResponse()
        similarMovieResponse = similarMockRepo.getSimilarMovieResponse()
        
        similarMovieCollectionView = getSimilarMovieCollectionView()
        similarMovieCollectionView.similarMovieResponse = similarMovieResponse
    }
    
    //MARK: - Number of sections
    
    func test_noOfSections_InMovieDetailTableView() {
        //Arrange
        let sections = controller.movieDetailDataSource.numberOfSections(in: controller.movieDetailCollectionView)
        //Assert
        XCTAssertEqual(sections, 4)
    }
    
    //MARK: - Synoypsis Cell
    func test_movieTitleLabelAssignment_InSynoypsisCell() {
        //Arrange
        let movieTitleLabelText = getSynoypsisCell().movieTitleLabel.text
        let movieTitle = synoypsisResponse?.originalTitle
        //Assert
        XCTAssertEqual(movieTitle, movieTitleLabelText)
        
    }
    
    func test_releaseDateLabelAssignment_InSynoypsisCell() {
        //Arrange
        let releaseDateLabelText = getSynoypsisCell().releaseDateLabel.text
        let relaseDate = "\(synoypsisResponse?.status ?? ""):  \(synoypsisResponse?.releaseDate ?? "")"
        //Assert
        XCTAssertEqual(releaseDateLabelText, relaseDate)
        
    }
    
    func test_ratingLabelAssignment_InSynoypsisCell() {
        //Arrange
        let ratingLabelText = getSynoypsisCell().ratingLabel.text
        let rating = "\(String(synoypsisResponse?.voteAverage ?? 0.0)) (\(String(synoypsisResponse?.voteCount ?? 0)))"
        //Assert
        XCTAssertEqual(ratingLabelText, rating)
        
    }
    
    func test_overViewLabelAssignment_InSynoypsisCell() {
        //Arrange
        let overViewLabelText = getSynoypsisCell().overViewLabel.text
        let overView = synoypsisResponse?.overview ?? ""
        //Assert
        XCTAssertEqual(overViewLabelText, overView)
        
    }
    
    //MARK: - Customer Review Section Header
    func test_customerReviewHeaderText_InMovieDetailView() {
        let headerView = controller.movieDetailDataSource.collectionView(controller.movieDetailCollectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: 2)) as! CustomerReviewCollectionReusableView
        XCTAssertEqual(headerView.headerLabel.text, "Customer Reviews")
    }
    
    //MARK: - Cast and Crew
    
    func test_castAndCrewHeaderText_InMovieDetailView() {
        let headerView = controller.movieDetailDataSource.collectionView(controller.movieDetailCollectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: 3)) as! MovieCastCollectionReusableView
        XCTAssertEqual(headerView.headerView.text, "Cast & Crew")
    }
    
    func test_numberOfRows_InMovieCastSection() {
        //Arrange
        let noOfRows = controller.movieDetailDataSource.collectionView(controller.movieDetailCollectionView, numberOfItemsInSection: 3)
        XCTAssertEqual(noOfRows, 3)
    }
    
    func test_castNameLabel_InMovieCastCell() {
        //Arrange
        let castNameLabelText = getMovieCastCell().castNameLabel.text
        let castValue = movieCastResponse?.castAndCrew?.first
        let castName =  "\(castValue?.name ?? "") \n(\(castValue?.character ?? ""))"
        //Assert
        XCTAssertEqual(castNameLabelText, castName)
    }
    
    //MARK: - Similar Movies
    func test_SimilarMovieHeaderText_InMovieDetailView() {
        //Arrange
        let headerView = controller.movieDetailDataSource.collectionView(controller.movieDetailCollectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: 1)) as! SimilarMovieCollectionReusableView
        //Assert
        XCTAssertEqual(headerView.headerLabel.text, "More Like This")
    }
    
    func test_SimilarMovieRow_InSimilarMovieCollectionView() {
        //Arrange
        let noOfRows = getSimilarMovieCollectionView().similarMovieCollectionDataSource.collectionView(getSimilarMovieCollectionView().similarCollectionView, numberOfItemsInSection: 0)
        //Assert
        XCTAssertEqual(noOfRows, 3)
    }
    
    func test_movieTitleLabel_InSimilarCollectionViewCell() {
        //Arrange
        let movieTitleLabel = getSimilarMovieCollectionViewCell().movieTitleLabel.text
        let movieTitle = similarMovieResponse?.results.first?.originalTitle ?? ""
        //Assert
        XCTAssertEqual(movieTitleLabel, movieTitle)
    }
    
    override func tearDownWithError() throws {
        controller = nil
        synoypsisResponse = nil
    }
}


extension MovieDetailViewControllerTest {
    func getSynoypsisCell() -> SynoypsisCollectionViewCell {
        return controller.movieDetailDataSource.collectionView(controller.movieDetailCollectionView, cellForItemAt: IndexPath(row: 0, section: 0))
            as! SynoypsisCollectionViewCell
    }
    
    func getMovieCastCell() -> MovieCastCollectionViewCell {
        return controller.movieDetailDataSource.collectionView(controller.movieDetailCollectionView, cellForItemAt: IndexPath(row: 0, section: 3))
            as! MovieCastCollectionViewCell
    }
    
    func getSimilarMovieCollectionView() -> SimilarMovieCollectionView {
        return controller.movieDetailDataSource.collectionView(controller.movieDetailCollectionView, cellForItemAt: IndexPath(row: 0, section: 1))
            as! SimilarMovieCollectionView
    }
    
    func getSimilarMovieCollectionViewCell() -> SimilarMovieCollectionViewCell {
        return getSimilarMovieCollectionView().similarMovieCollectionDataSource.collectionView(getSimilarMovieCollectionView().similarCollectionView, cellForItemAt: IndexPath(row: 0, section: 0))
            as! SimilarMovieCollectionViewCell
    }
}
