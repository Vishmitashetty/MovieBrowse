//
//  CustomerReviewViewControllerTest.swift
//  MovieAppTests
//
//  Created by Vishmita Shetty on 25/04/21.
//

import XCTest
@testable import MovieApp

class CustomerReviewViewControllerTest: XCTestCase {

    var controller: CustomerReviewViewController!
    var customerReviewList: UserReviewsResponse?
    
    override func setUpWithError() throws {
        super.setUp()
        let mockRepo = MockUserReviewsRepository.shared
        let storyBoard = UIStoryboard(name: "MovieDetail", bundle: nil)
        controller = (storyBoard.instantiateViewController(withIdentifier: "CustomerReviewViewController") as! CustomerReviewViewController)
        controller.userReviewsRepository = mockRepo
        controller.customerReviewDataSource.customerReview = []
        controller.loadViewIfNeeded()
        customerReviewList = mockRepo.getUserReviewResponse()
    }
    
    func test_noOfRows_InCustomerReviewVC() {
        //Arrange
        let customerReviewListCount = customerReviewList?.results.count ?? 0
        //Assert
        XCTAssertEqual(customerReviewListCount, 3)
    }
    
    func test_authorNameLabelAssignment_InCustomerReviewCell() {
        //Arrange
        let authorNameLabelText = getCustomerReviewCell().authorNameLabel.text
        let authorName = customerReviewList?.results.first?.author
        //Assert
        XCTAssertEqual(authorNameLabelText, authorName)
    }
    
    func test_reviewDateLabelAssignment_InCustomerReviewCell() {
        //Arrange
        let reviewDateLabelText = getCustomerReviewCell().reviewDateLabel.text
        let customerReview = customerReviewList?.results.first
        let reviewText = "@\(customerReview?.authorDetails?.username ?? "") \n\(String.convertDateToStringUsingTimeStamp(customerReview?.createdAt ?? ""))"
        //Assert
        XCTAssertEqual(reviewDateLabelText, reviewText)
    }
    
    func test_ratingStarLabelAssignment_InCustomerReviewCell() {
        //Arrange
        let ratingStarLabel = getCustomerReviewCell().ratingStarLabel.text
        let rating = customerReviewList?.results.first?.authorDetails?.rating
        //Assert
        XCTAssertEqual(ratingStarLabel, String(rating ?? 0.0))
    }
    
    func test_contentLabelAssignment_InCustomerReviewCell() {
        //Arrange
        let contentLabel = getCustomerReviewCell().contentLabel.text
        let content = customerReviewList?.results.first?.content
        //Assert
        XCTAssertEqual(contentLabel, content)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        controller = nil
        customerReviewList = nil
    }

}


extension CustomerReviewViewControllerTest {
    func getCustomerReviewCell() -> CustomerReviewTableViewCell {
        
        return controller.customerReviewDataSource.tableView(controller.customerReviewTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! CustomerReviewTableViewCell
    }
}
