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
    var movieSearchRepository: MovieSearchRepository = MovieSearchRepository.shared
    var pageNo: Int = 1
    var movieList: MovieListResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        setup()
        getNowPlaying(pageNo: 1)
        self.title = "Movie App"
        setCustomNavigation(isLeftBarButton: false)
        self.navigationController?.view.backgroundColor = .white
    }
    
    @IBAction func searchMovie(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "MovieList", bundle: nil)
        guard
            let vc = storyBoard.instantiateViewController(withIdentifier: "MovieSearchTableViewController") as? MovieSearchTableViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
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
        self.pageNo = pageNo
        if self.pageNo == 1 {
            //If page no is 1 then reset the data source to show latest data
            self.movieCollectionDataSource.movieList = []
        }
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
    
//    fileprivate func getMovieBySearch(query: String, pageNo: Int) {
//        self.pageNo = pageNo
//        movieSearchRepository.getMovieBySearch(pageNo: pageNo, query: query) {[weak self] (result) in
//            guard let weakSelf = self else {return}
//
//            switch result {
//            case .success(let movieList, _):
//                //Reset existing data source and show search result
//                weakSelf.movieCollectionDataSource.movieList = []
//                weakSelf.loadMovieData(movieList: movieList)
//            case .failure:
//                break
//            }
//        }
//
//    }
    
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
        vc.movieId = Int(movieId ?? 0)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if movieCollectionDataSource.movieList.count == indexPath.row + 1 && (movieList?.totalPages ?? 0) > pageNo {
            pageNo += 1
//            if search.isActive, let searchText = search.searchBar.text {
//                getMovieBySearch(query: searchText, pageNo: pageNo)
//            } else {
                getNowPlaying(pageNo: pageNo)
           // }
        }
    }
}
