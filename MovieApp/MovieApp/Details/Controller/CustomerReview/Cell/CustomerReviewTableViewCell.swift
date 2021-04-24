//
//  CustomerReviewTableViewCell.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 24/04/21.
//

import UIKit

class CustomerReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var avtarImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var ratingStarLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(_ userReview: UserReview?) {
        authorNameLabel.text = userReview?.author ?? ""
        ratingStarLabel.text = String(userReview?.authorDetails?.rating ?? 0.0)
        reviewDateLabel.text = "@\(userReview?.authorDetails?.username ?? "") \n\(String.convertDateToStringUsingTimeStamp(userReview?.createdAt ?? ""))"
        contentLabel.text = userReview?.content ?? ""
        
        if let profilePath = userReview?.authorDetails?.avatarPath {
            let imageUrl = "https://image.tmdb.org/t/p/w500" + "\(profilePath)"
            avtarImageView.loadImage(with: imageUrl, placeholder: UIImage(named: "neutralProfileIcon"))
            avtarImageView.layer.cornerRadius = avtarImageView.frame.height/2
            avtarImageView.layer.masksToBounds = true
        }
    }
}
