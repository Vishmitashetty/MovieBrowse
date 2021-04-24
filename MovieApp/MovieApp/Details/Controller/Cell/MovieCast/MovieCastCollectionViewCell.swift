//
//  MovieCastCollectionViewCell.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 24/04/21.
//

import UIKit

class MovieCastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ cast: Cast?) {
        castNameLabel.text = cast?.name ?? ""
        if let profilePath = cast?.profilePath {
            let imageUrl = "https://image.tmdb.org/t/p/w500" + "\(profilePath)"
            posterImageView.loadImage(with: imageUrl, placeholder: UIImage(named: "neutralProfileIcon"))
            posterImageView.setCornerRadius()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }

}
