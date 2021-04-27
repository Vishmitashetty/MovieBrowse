//
//  MovieListDataSource.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation
import UIKit

//MARK: - UICollectionViewDataSource

class MovieListCollectionDataSource: NSObject, UICollectionViewDataSource {
    var movieList: [Movie] = []
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else {return UICollectionViewCell()}
        let movie = movieList[indexPath.row]
        cell.configureCell(movie)
        return cell
    }
}
