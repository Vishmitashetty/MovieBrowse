//
//  SimilarCollectionViewDataSource.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 24/04/21.
//

import UIKit

class SimilarCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var similarMovies: [SimilarMovie] = []
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCollectionViewCell.identifier, for: indexPath) as? SimilarMovieCollectionViewCell else {return UICollectionViewCell()}
        let similarMovieResult = similarMovies[indexPath.row]
        cell.configureCell(similarMovieResult)
        return cell
    }
}
