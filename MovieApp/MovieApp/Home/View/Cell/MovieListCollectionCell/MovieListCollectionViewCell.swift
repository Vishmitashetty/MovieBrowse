//
//  MovieListCollectionViewCell.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //Assign data
    func configureCell(_ movie: Movie?) {
        movieTitle.text = movie?.title ?? ""
        movieReleaseDate.text = movie?.releaseDate ?? ""
        ratingLabel.text = "\(movie?.voteAverage ?? 0.0) (\(Int(movie?.voteCount ?? 0.0)))"
        bookButton.setButton()
        if let posterPath = movie?.posterPath {
            let imageUrl = "https://image.tmdb.org/t/p/w500" + "\(posterPath)"
            posterImage.loadImage(with: imageUrl)
        } else {
            posterImage.image = UIImage(named: "neutralProfileIcon")
        }
        posterImage.setCornerRadius()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
    }

}
