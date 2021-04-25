//
//  MovieCastResponse.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation


struct MovieCastResponse: Codable {
    let id: Int?
    let cast: [Cast]?
    let crew: [Cast]?
}

struct Cast: Codable {
    let id: Int?
    let name: String?
    let popularity: Float?
    let profilePath: String?
    let character: String?
}

extension MovieCastResponse {
    
    var castAndCrew: [Cast]? {
        var castAndCrewValue: [Cast] = []
        castAndCrewValue.append(contentsOf: cast ?? [])
        castAndCrewValue.append(contentsOf: crew ?? [])
        return castAndCrewValue
    }
}
