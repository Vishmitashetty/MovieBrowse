//
//  SynoypsisRepository.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation

protocol GetSynoypsisRepositoryProtocol {
    func getSynoypsis(movieId: Int?, completionHandler: @escaping (Result<SynoypsisResponse, TaskError>) -> Void)
}

class GetSynoypsisRepository: GetSynoypsisRepositoryProtocol {
    
    static let shared = GetSynoypsisRepository()
    private init() {}
    
    func getSynoypsis(movieId: Int?, completionHandler: @escaping (Result<SynoypsisResponse, TaskError>) -> Void) {
        let task = HTTPTask()
        guard
            let movieId = movieId else { return }
        
        task.GET(api: MovieApiRoute.synoypsis(movieId: String(movieId))) { (result: Result<SynoypsisResponse, TaskError>) -> Void in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}
