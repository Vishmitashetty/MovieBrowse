//
//  MockGetSynoypsisRepository.swift
//  MovieAppTests
//
//  Created by Vishmita Shetty on 25/04/21.
//

import Foundation
@testable import MovieApp

class MockGetSynoypsisRepository: GetSynoypsisRepositoryProtocol {
    
    static let shared = MockGetSynoypsisRepository()
    private var synoypsis: SynoypsisResponse?
    
    private init() {}
    
    func getSynoypsis(movieId: Int?, completionHandler: @escaping (Result<SynoypsisResponse, TaskError>) -> Void) {
        
        let path = Bundle(for: type(of: self)).path(forResource: "SynoypsisResponse", ofType: "json")
        ProcessDummyJSON.sharedObject.processJSONResponse(path: path) { (result: Result<SynoypsisResponse, TaskError>) in
            switch result {
            case .success(let response, _):
                self.synoypsis = response
            case .failure:
                break
            }
            completionHandler(result)
        }
    }
    
    func getSynoypsisResponse() -> SynoypsisResponse? {
        return synoypsis
    }
}
