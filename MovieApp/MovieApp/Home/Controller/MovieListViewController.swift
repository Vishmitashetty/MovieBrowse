//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var movieCollectionDataSource = MovieListCollectionDataSource()
    var movieListRepository: MovieListRepositoryProtocol = MovieListRepository.shared
    var pageNo: Int = 1
    var movieList: MovieListResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        setup()
        getNowPlaying(pageNo: pageNo)
    }
}

//MARK: - API Call
extension MovieListViewController {
    
    fileprivate func setup() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = movieCollectionDataSource
    }
    
    func register() {
        movieCollectionView.register(UINib(nibName: "\(MovieListCollectionViewCell.self)", bundle: Bundle.main), forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
    }
    
    fileprivate func getNowPlaying(pageNo: Int) {
        movieListRepository.getNowPlaying(pageNo: pageNo) { [weak self] (result) in
            guard let weakSelf = self else {return}
            
            switch result {
            case .success(let movieList, _):
                weakSelf.loadMovieData(movieList: movieList)
            case .failure:
                break
            }
        }
    }
    
    fileprivate func loadMovieData(movieList: MovieListResponse) {
        guard
            let movieArray = movieList.results else {
            return
        }
        
        movieCollectionView.performBatchUpdates ({
            let indexPath = IndexPath(row: movieCollectionDataSource.movieList.count - 1, section: 0)
            movieCollectionDataSource.movieList.append(contentsOf: movieArray)
            self.movieList = movieList
            movieCollectionView.insertItems(at: [indexPath])
        }, completion: nil)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Constants.ScreenSize.SCREEN_WIDTH - 64
        return CGSize(width: floor(width/2.0), height: 255)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
}

//MARK: - UICollectionViewDelegate
extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //ToDo
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //ToDo
        if movieCollectionDataSource.movieList.count == indexPath.row + 1 && (movieList?.totalPages ?? 0) > pageNo {
            pageNo += 1
            getNowPlaying(pageNo: pageNo)
        }
    }
}
