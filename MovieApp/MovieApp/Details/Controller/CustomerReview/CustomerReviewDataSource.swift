//
//  CustomerReviewDataSource.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 24/04/21.
//

import UIKit

//MARK: - UITableViewDataSource
class CustomerReviewDataSource: NSObject, UITableViewDataSource {
    var customerReview: [UserReview] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if customerReview.count > 0 {
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "No Reviews Available"
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = NSTextAlignment.center
            tableView.backgroundView = noDataLabel
            
        }
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
