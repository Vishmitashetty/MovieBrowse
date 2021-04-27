//
//  MovieSearchTableViewController.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 25/04/21.
//

import UIKit
import CoreData

class MovieSearchTableViewController: UITableViewController {
    //Repository defination
    var movieSearchRepository: MovieSearchRepositoryProtocol = MovieSearchRepository.shared
    var movieResponse: MovieListResponse?
    var movieList: [Movie]?
    
    lazy var recentSearchResultsController: NSFetchedResultsController<RecentSearches> = {
        let fetchRequest: NSFetchRequest<RecentSearches> = RecentSearches.fetchRequest()
        fetchRequest.fetchLimit = 5
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let recentSearchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        return recentSearchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        setupView()
        fetchRecentMovie()
    }
    
    //Recent movie fetch from core data
    fileprivate func fetchRecentMovie() {
        do {
            try recentSearchResultsController.performFetch()
            recentSearchResultsController.delegate = self
        } catch {
            fatalError("Error fetching Recent Searches from CoreData")
        }
    }
    
    //Setup search input field
    fileprivate func setupSearch() {
        let search = UISearchController(searchResultsController: nil)
        search.hidesNavigationBarDuringPresentation = true
        search.searchBar.searchBarStyle = .default
        search.searchBar.backgroundImage = UIImage()
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }
    
    fileprivate func setupView() {
        tableView.tableFooterView = UIView()
        setupSearch()
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .white
    }
}

//MARK: - UITableViewDataSource
extension MovieSearchTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return movieList?.count ?? 0
        case 1:
            return recentSearchResultsController.fetchedObjects?.count ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.identifier, for: indexPath) as? MovieSearchTableViewCell else {return UITableViewCell()}
            cell.movieSearchLabel.text = movieList?[indexPath.row].title ?? ""
            return cell
        case 1:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier, for: indexPath) as? RecentSearchTableViewCell else {return UITableViewCell()}
            let recentMovie = recentSearchResultsController.object(at: IndexPath(row: indexPath.row, section: 0))
            cell.recentSearchLabel.text = recentMovie.movieName
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "    Recent Searches"
        default:
            return ""
        }
    }
}

//MARK: - UITableViewDelegate
extension MovieSearchTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Push movie detail view
        let storyBoard = UIStoryboard(name: Constants.StoryBoardName.movieDetail, bundle: nil)
        guard
            let vc = storyBoard.instantiateViewController(identifier: Constants.StoryBoardIdentifier.movieDetailViewController) as? MovieDetailViewController else {return}
        
        switch indexPath.section {
        case 0:
            guard let movie = movieList?[indexPath.row], movie.id != 0 else {return}
            RecentSearchesOperations.shared.insertRecentSearches(movie: movie)
            vc.movieId = Int(movie.id ?? 0)
            vc.movieTitle = movie.title
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let recentMovie = recentSearchResultsController.object(at: IndexPath(row: indexPath.row, section: 0))
            vc.movieId = Int(recentMovie.movieId)
            vc.movieTitle = recentMovie.movieName
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

//MARK: - UISearchResultsUpdating
extension MovieSearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.isEmpty == false {
            getMovieBySearch(query: text)
        }
    }
}


extension MovieSearchTableViewController {
    func getMovieBySearch(query: String) {
        movieSearchRepository.getMovieBySearch(pageNo: 1, query: query) {[weak self] (result) in
            guard let weakSelf = self else {return}
            
            switch result {
            case .success(let movieList, _):
                weakSelf.movieResponse = movieList
                //Apply filter
                weakSelf.movieList = movieList.filterMovie(pattern: query)
                weakSelf.tableView.reloadData()
            case .failure:
                break
            }
        }
    }
    
    fileprivate func register() {
        //Cell Register
        tableView.register(UINib(nibName: "\(RecentSearchTableViewCell.self)", bundle: Bundle.main), forCellReuseIdentifier: RecentSearchTableViewCell.identifier)
        tableView.register(UINib(nibName: "\(MovieSearchTableViewCell.self)", bundle: Bundle.main), forCellReuseIdentifier: MovieSearchTableViewCell.identifier)
    }
}

//MARK: - NSFetchedResultsControllerDelegate
extension MovieSearchTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
    }
}
