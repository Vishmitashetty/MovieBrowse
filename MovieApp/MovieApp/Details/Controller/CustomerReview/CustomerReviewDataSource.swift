//
//  CustomerReviewDataSource.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 24/04/21.
//

import UIKit


class CustomerReviewDataSource: NSObject, UITableViewDataSource {
  
    var customerReview: [UserReview] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomerReviewTableViewCell.identifier) as? CustomerReviewTableViewCell else {return UITableViewCell()}
        cell.configureCell(customerReview[indexPath.row])
        return cell
    }
}
