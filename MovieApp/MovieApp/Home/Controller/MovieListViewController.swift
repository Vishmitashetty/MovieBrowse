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
        self.title = "Movie App"
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
        movieCollectionDataSource.movieList.append(contentsOf: movieArray)
        self.movieList = movieList
        let indexPaths = (0 ..< movieCollectionDataSource.movieList.count).map { IndexPath(row: $0, section: 0) }
        movieCollectionView.performBatchUpdates ({
            movieCollectionView.insertItems(at: indexPaths)
        }, completion: nil)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Constants.ScreenSize.SCREEN_WIDTH - 64
        return CGSize(width: floor(width/2.0), height: 332)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
}

//MARK: - UICollectionViewDelegate
extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieId = movieCollectionDataSource.movieList[indexPath.row].id
        let storyBoard = UIStoryboard(name: "MovieDetail", bundle: nil)
        guard
            let vc = storyBoard.instantiateViewController(identifier: "movieDetailViewController") as? MovieDetailViewController else {return}
        vc.movieId = movieId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if movieCollectionDataSource.movieList.count == indexPath.row + 1 && (movieList?.totalPages ?? 0) > pageNo {
            pageNo += 1
            getNowPlaying(pageNo: pageNo)
        }
    }
}
