//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 23/04/21.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieDetailCollectionView: UICollectionView!
    
    var movieDetailDataSource = MovieDetailDataSource()
    var movieId: Int?
    
    var synoypsisRepository = GetSynoypsisRepository.shared
    var movieCastRepository = MovieCastRepository.shared
    var similarMovieRepository = SimilarMovieRepository.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailCollectionView.dataSource = movieDetailDataSource
        movieDetailCollectionView.delegate = self
        register()
        
        getSynoypsis(movieId: movieId)
        getMovieCast(movieId: movieId)
        getSimilarMovie(movieId: movieId)
    }
    
    func register() {
        //Cell Register
        movieDetailCollectionView.register(UINib(nibName: "\(SynoypsisCollectionViewCell.self)", bundle: Bundle.main), forCellWithReuseIdentifier: SynoypsisCollectionViewCell.identifier)
        movieDetailCollectionView.register(UINib(nibName: "\(SimilarMovieCollectionView.self)", bundle: Bundle.main), forCellWithReuseIdentifier: SimilarMovieCollectionView.identifier)
        movieDetailCollectionView.register(UINib(nibName: "\(MovieCastCollectionViewCell.self)", bundle: Bundle.main), forCellWithReuseIdentifier: MovieCastCollectionViewCell.identifier)
        
        //Section Header
        movieDetailCollectionView.register(UINib(nibName: "\(SimilarMovieCollectionReusableView.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SimilarMovieCollectionReusableView.identifier)
        movieDetailCollectionView.register(UINib(nibName: "\(CustomerReviewCollectionReusableView.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomerReviewCollectionReusableView.identifier)
        movieDetailCollectionView.register(UINib(nibName: "\(MovieCastCollectionReusableView.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MovieCastCollectionReusableView.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setCustomNavigation()
        setNotificationObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotificationObserver()
    }
    
    func setNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(showCustomerReviewPage(notification:)), name: Notification.Name(Constants.NotificationObserver.customerReviewLoad), object: nil)
    }
    
    func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(Constants.NotificationObserver.customerReviewLoad), object: nil)
    }
}

//MARK: - API calls
extension MovieDetailViewController {
    fileprivate func getSynoypsis(movieId: Int?) {
        synoypsisRepository.getSynoypsis(movieId: movieId) { [weak self] (result) in
            guard let weakSelf = self else {return}
            switch result {
            case .success(let synoypsisResponse, _):
                weakSelf.movieDetailDataSource.synoypsisResponse = synoypsisResponse
                weakSelf.movieDetailCollectionView.reloadSections(IndexSet([0]))
            case .failure:
                break
            }
        }
    }
    
    fileprivate func getMovieCast(movieId: Int?) {
        movieCastRepository.getMovieCast(movieId: movieId) { [weak self] (result) in
            guard let weakSelf = self else {return}
            switch result {
            case .success(let movieCastResponse, _):
                weakSelf.movieDetailDataSource.movieCastResponse = movieCastResponse
                weakSelf.movieDetailCollectionView.reloadSections(IndexSet([3]))
            case .failure:
                break
            }
        }
    }
    
    fileprivate func getSimilarMovie(movieId: Int?) {
        similarMovieRepository.getSimilarMovies(movieId: movieId, pageNo: 1) { [weak self] (result) in
            guard let weakSelf = self else {return}
            switch result {
            case .success(let similarMovieResponse, _):
                weakSelf.movieDetailDataSource.movieId = movieId
                weakSelf.movieDetailDataSource.similarMovieResponse = similarMovieResponse
                weakSelf.movieDetailCollectionView.reloadSections(IndexSet([1]))
            case .failure:
                break
            }
        }
    }
}

//MARK: - UICollectionViewDelegate
extension MovieDetailViewController: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Cell width
        let width = Constants.ScreenSize.SCREEN_WIDTH - 40
        switch indexPath.section {
        case 0:
            //Cell height
            let subHeadingFrame = NSString(string: movieDetailDataSource.synoypsisResponse?.overview ?? "").boundingRect(with: CGSize(width: width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.init(name: "HelveticaNeue-Thin", size: 13)!], context: nil).size
            let totalHeight = subHeadingFrame.height + 320
            return CGSize(width: floor(width), height: totalHeight)
        case 1:
            let headerHeight = movieDetailDataSource.similarMovieResponse?.results.count == 0 ? 0 : 300
            return CGSize(width: floor(width), height: CGFloat(headerHeight))
        case 3:
            return CGSize(width: floor((width - 40)/2), height: 290)
        default:
            return CGSize.zero
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 3:
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 1:
            let headerHeight = movieDetailDataSource.similarMovieResponse?.results.count == 0 ? 0 : 60
            return CGSize(width: Constants.ScreenSize.SCREEN_WIDTH, height: CGFloat(headerHeight))
        case 2:
            return CGSize(width: Constants.ScreenSize.SCREEN_WIDTH, height: 60)
        case 3:
            return CGSize(width: Constants.ScreenSize.SCREEN_WIDTH, height: 60)
        default:
            return CGSize.zero
        }
    }
}

//MARK: - Miscellanous
extension MovieDetailViewController {
    
    @objc func showCustomerReviewPage(notification: Notification) {
        let storyBoard = UIStoryboard(name: "MovieDetail", bundle: nil)
        guard
            let vc = storyBoard.instantiateViewController(identifier: "CustomerReviewViewController") as? CustomerReviewViewController else {return}
        vc.movieId = movieId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
