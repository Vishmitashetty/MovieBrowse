//
//  CustomerReviewViewController.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 24/04/21.
//

import UIKit

class CustomerReviewViewController: UIViewController {

    @IBOutlet weak var customerReviewTableView: UITableView!
    //Table view data source
    var customerReviewDataSource = CustomerReviewDataSource()
    //Repository assignment
    var userReviewsRepository: UserReviewsRepositoryProtocol = UserReviewsRepository.shared
    
    var movieId: Int?
    var userReviewResponse: UserReviewsResponse?
    var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customerReviewTableView.dataSource = customerReviewDataSource
        customerReviewTableView.delegate = self
        customerReviewTableView.tableFooterView = UIView()
        register()
        getUserReview(movieId: movieId, page: page)
        self.title = "Reviews"
    }
}

//MARK: - API Call
extension CustomerReviewViewController {
    
    fileprivate func register() {
        //Cell Register
        customerReviewTableView.register(UINib(nibName: "\(CustomerReviewTableViewCell.self)", bundle: Bundle.main), forCellReuseIdentifier: CustomerReviewTableViewCell.identifier)
    }
    
    fileprivate func getUserReview(movieId: Int?, page: Int) {
        self.startActivityIndicator()
        userReviewsRepository.getReviews(movieId: movieId, pageNo: page) { [weak self] (result) in
            guard let weakSelf = self else {return}
            weakSelf.stopActivityIndicator()
            switch result {
            case .success(let userReviewResponse, _):
                weakSelf.userReviewResponse = userReviewResponse
                weakSelf.reloadTableView(userReviewResponse.results)
               break
            case .failure:
                break
            }
        }
    }
    
    fileprivate func reloadTableView(_ userReviewList: [UserReview]?) {
        customerReviewDataSource.customerReview.append(contentsOf: userReviewList ?? [])
        let indexPaths = (0 ..< customerReviewDataSource.customerReview.count).map { IndexPath(row: $0, section: 0) }
        customerReviewTableView.beginUpdates()
        customerReviewTableView.insertRows(at: indexPaths, with: .none)
        customerReviewTableView.endUpdates()
    }
}

//MARK: - UITableViewDelegate
extension CustomerReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if userReviewResponse?.results.count == indexPath.row + 1 && (userReviewResponse?.totalPages ?? 0) > page {
            page += 1
            getUserReview(movieId: movieId, page: page)
        }
    }
}
