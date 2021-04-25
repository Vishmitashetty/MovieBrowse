//
//  MovieSearchTableViewController.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 25/04/21.
//

import UIKit

class MovieSearchTableViewController: UITableViewController {

    var movieSearchRepository: MovieSearchRepository = MovieSearchRepository.shared
    var movieResponse: MovieListResponse?
    var recentSearchers: [RecentSearches]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        recentSearchers = RecentSearchesOperations.shared.fetchRecentSearches()
        self.tableView.reloadSections(IndexSet([1]), with: .none)
        setupSearch()
        setCustomNavigation()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .white
    }
    
    fileprivate func setupSearch() {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.searchBarStyle = .default
        search.searchBar.backgroundImage = UIImage()
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.titleView = search.searchBar
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return movieResponse?.results?.count ?? 0
        case 1:
            return recentSearchers?.count ?? 0
        default:
            return 0
        }
       
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
           guard
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.identifier, for: indexPath) as? MovieSearchTableViewCell else {return UITableViewCell()}
            cell.movieSearchLabel.text = movieResponse?.results?[indexPath.row].title ?? ""
            return cell
        case 1:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.identifier, for: indexPath) as? RecentSearchTableViewCell else {return UITableViewCell()}
            cell.recentSearchLabel.text = recentSearchers?[indexPath.row].movieName ?? ""
            return cell
        default:
            return UITableViewCell()
        }
        
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Recent Searches"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = movieResponse?.results?[indexPath.row] else {return}
        RecentSearchesOperations.shared.insertRecentSearches(movie: movie)
        //Push movie detail view
        let storyBoard = UIStoryboard(name: "MovieDetail", bundle: nil)
        guard
            let vc = storyBoard.instantiateViewController(identifier: "movieDetailViewController") as? MovieDetailViewController else {return}
        vc.movieId = Int(movie.id ?? 0)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieSearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.isEmpty == false {
            getMovieBySearch(query: text)
        }
    }
}

extension MovieSearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        // tap on cancel click
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Click on search button on keyboard
        
    }
}


extension MovieSearchTableViewController {
    fileprivate func getMovieBySearch(query: String) {
        movieSearchRepository.getMovieBySearch(pageNo: 1, query: query) {[weak self] (result) in
            guard let weakSelf = self else {return}
            
            switch result {
            case .success(let movieList, _):
                weakSelf.movieResponse = movieList
                self?.tableView.reloadSections(IndexSet([0]), with: .none)
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
