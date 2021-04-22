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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ movie: Movie?) {
        movieTitle.text = movie?.title ?? ""
        movieReleaseDate.text = movie?.releaseDate ?? ""
    }

}
