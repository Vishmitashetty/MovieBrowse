//
//  RecentSearches.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 25/04/21.
//

import Foundation
import CoreData

class RecentSearchesOperations {
    static let shared = RecentSearchesOperations()
    let managedObjectContext = CoreDataStack.shared.managedContext
    
    func insertRecentSearches(movie: Movie) {
        guard
            let movieId = movie.id,
            let movieName = movie.title else {
            return
        }
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = CoreDataStack.shared.managedContext
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        privateMOC.perform {
            guard let entity = NSEntityDescription.entity(forEntityName: RecentSearches.entityName, in: privateMOC) else { return }
            let recentSearchesEntity = RecentSearches(entity: entity, insertInto: privateMOC)
            recentSearchesEntity.insertRecentSearch(movieId: movieId, movieName: movieName)
            
            do {
                try privateMOC.save()
                self.managedObjectContext.performAndWait {
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func fetchRecentSearches() -> [RecentSearches] {
        let privateMOC = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        privateMOC.parent = CoreDataStack.shared.managedContext
        var recentSearch: [RecentSearches]?
        let recentSearchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: RecentSearches.entityName)
        
        privateMOC.performAndWait {
            do {
                recentSearch = try privateMOC.fetch(recentSearchRequest) as? [RecentSearches]
            } catch {
                debugPrint("Error fetching cart id")
            }
        }
        return recentSearch ?? []
    }
}
