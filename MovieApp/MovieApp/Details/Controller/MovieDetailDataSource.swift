//
//  MovieDetailDataSource.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 23/04/21.
//

import UIKit

class MovieDetailDataSource: NSObject, UICollectionViewDataSource {
    
    var synoypsisResponse: SynoypsisResponse?
    var similarMovieResponse: SimilarMovieResponse?
    var movieCastResponse: MovieCastResponse?
    var movieId: Int?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 3:
            return movieCastResponse?.cast?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            return fetchMovieSynoypsis(collectionView, indexPath: indexPath)
        case 1:
            return fetchSimilarMovie(collectionView, indexPath: indexPath)
        case 3:
            return fetchMovieCast(collectionView, indexPath: indexPath)
        default:
            return UICollectionViewCell()
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            switch indexPath.section {
            case 1:
                guard
                    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SimilarMovieCollectionReusableView.identifier, for: indexPath) as? SimilarMovieCollectionReusableView else {return UICollectionReusableView()}
                return headerView
            case 2:
                guard
                    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomerReviewCollectionReusableView.identifier, for: indexPath) as? CustomerReviewCollectionReusableView else {return UICollectionReusableView()}
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showUserReview))
                headerView.addGestureRecognizer(tapGesture)
                return headerView
            case 3:
                guard
                    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MovieCastCollectionReusableView.identifier, for: indexPath) as? MovieCastCollectionReusableView else {return UICollectionReusableView()}
                return headerView
            
            default:
                return UICollectionReusableView()
            }
        default:
            return UICollectionReusableView()
        }
    }
}

//MARK: - Cell Configuration
extension MovieDetailDataSource {
    
    fileprivate func fetchMovieSynoypsis(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SynoypsisCollectionViewCell.identifier, for: indexPath) as? SynoypsisCollectionViewCell else {return UICollectionViewCell()}
        cell.configureCell(synoypsisResponse)
        return cell
    }
    
    fileprivate func fetchSimilarMovie(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCollectionView.identifier, for: indexPath) as? SimilarMovieCollectionView else {return UICollectionViewCell()}
        cell.movieId = movieId
        cell.configureCell(similarMovieResponse)
        return cell
    }
    
    fileprivate func fetchMovieCast(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCastCollectionViewCell.identifier, for: indexPath) as? MovieCastCollectionViewCell else {return UICollectionViewCell()}
        let cast = movieCastResponse?.cast?[indexPath.row]
        cell.configureCell(cast)
        return cell
    }
    
    @objc fileprivate func showUserReview() {
        NotificationCenter.default.post(name: Notification.Name(Constants.NotificationObserver.customerReviewLoad), object: nil)
    }
}
