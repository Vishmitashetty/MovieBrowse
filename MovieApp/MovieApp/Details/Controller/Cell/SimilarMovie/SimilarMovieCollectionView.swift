//
//  SimilarMovieCollectionView.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 24/04/21.
//

import UIKit

class SimilarMovieCollectionView: UICollectionViewCell {

    @IBOutlet weak var similarCollectionView: UICollectionView!
    
    var similarMovieCollectionDataSource = SimilarCollectionViewDataSource()
    var similarMovieRepository = SimilarMovieRepository.shared
    var page: Int = 1
    var movieId: Int?
    var similarMovieResponse: SimilarMovieResponse?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        similarCollectionView.dataSource = similarMovieCollectionDataSource
        similarCollectionView.delegate = self
        register()

    }
    
    func configureCell(_ similarMovie: SimilarMovieResponse?) {
        similarMovieResponse = similarMovie
        self.similarMovieCollectionDataSource.similarMovies = similarMovie?.results ?? []
    }
    
    fileprivate func register() {
        similarCollectionView.register(UINib(nibName: "\(SimilarMovieCollectionViewCell.self)", bundle: Bundle.main), forCellWithReuseIdentifier: SimilarMovieCollectionViewCell.identifier)
    }
    
    fileprivate func reloadCollectionView(similarMovieResponse: SimilarMovieResponse?) {
        similarMovieCollectionDataSource.similarMovies.append(contentsOf: similarMovieResponse?.results ?? [])
        let indexPaths = (0 ..< similarMovieCollectionDataSource.similarMovies.count).map { IndexPath(row: $0, section: 0) }
        similarCollectionView.performBatchUpdates ({
            similarCollectionView.insertItems(at: indexPaths)
        }, completion: nil)
    }
    
    
    fileprivate func getSimilarMovie(movieId: Int?, pageNo:Int) {
        similarMovieRepository.getSimilarMovies(movieId: movieId, pageNo: pageNo) { [weak self] (result) in
            guard let weakSelf = self else {return}
            switch result {
            case .success(let similarMovieResponse, _):
                weakSelf.reloadCollectionView(similarMovieResponse: similarMovieResponse)
            case .failure:
                break
            }
        }
    }

}

//MARK: - UICollectionViewDelegate
extension SimilarMovieCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if similarMovieCollectionDataSource.similarMovies.count == indexPath.row + 1 && (similarMovieResponse?.totalPages ?? 0) > page {
            page += 1
            getSimilarMovie(movieId: movieId, pageNo: page)
        }
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SimilarMovieCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSize = similarMovieCollectionDataSource.similarMovies.count == 0 ? CGSize(width: 0, height: 0) : CGSize(width: 160, height: 292)
        return itemSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
