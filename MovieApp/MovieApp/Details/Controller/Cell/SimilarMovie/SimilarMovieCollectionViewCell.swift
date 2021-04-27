//
//  SimilarMovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 24/04/21.
//

import UIKit

class SimilarMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //Assign cell
    func configureCell(_ similarMovie: SimilarMovie?) {
        movieTitleLabel.text = similarMovie?.originalTitle ?? ""
        if let posterPath = similarMovie?.posterPath {
            let imageUrl = "https://image.tmdb.org/t/p/w500" + "\(posterPath)"
            posterImageView.setCornerRadius()
            posterImageView.loadImage(with: imageUrl)
        }
    }
}
