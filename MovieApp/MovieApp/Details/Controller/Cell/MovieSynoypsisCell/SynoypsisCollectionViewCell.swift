//
//  SynoypsisCollectionViewCell.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 23/04/21.
//

import UIKit

class SynoypsisCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterPathImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ synoypsisResponse: SynoypsisResponse?) {
        movieTitleLabel.text = synoypsisResponse?.originalTitle ?? ""
        releaseDateLabel.text = "\(synoypsisResponse?.status ?? ""):  \(synoypsisResponse?.releaseDate ?? "")"
        ratingLabel.text = "\(String(synoypsisResponse?.voteAverage ?? 0.0)) (\(String(synoypsisResponse?.voteCount ?? 0)))"
        overViewLabel.text = synoypsisResponse?.overview ?? ""
        if let posterPath = synoypsisResponse?.posterPath {
            let imageUrl = "https://image.tmdb.org/t/p/w500" + "\(posterPath)"
            posterPathImageView.loadImage(with: imageUrl)
            bannerImageView.loadImage(with: imageUrl)
            posterPathImageView.addBlurEffect()
        } 
    }

}
