//
//  RecentSearches.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 25/04/21.
//

import Foundation
import CoreData
import os.log

class RecentSearchesOperations {
    static let shared = RecentSearchesOperations()
    let managedObjectContext = CoreDataStack.shared.managedContext
    
    //Insert recent search in coredata unique identifer is movie id
    func insertRecentSearches(movie: Movie) {
        Logger.dbDebugging(entityName: RecentSearches.entityName, operationName: Logger.DBOperations.insert.rawValue)
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
                        Logger.dbOperationSuccess(entityName: RecentSearches.entityName, operationName: Logger.DBOperations.insert.rawValue)
                    } catch {
                        Logger.dbOperationFailure(entityName: RecentSearches.entityName, operationName: Logger.DBOperations.insert.rawValue, message: error.localizedDescription)
                    }
                }
            } catch {
                Logger.dbOperationFailure(entityName: RecentSearches.entityName, operationName: Logger.DBOperations.insert.rawValue, message: error.localizedDescription)
            }
        }
    }
}
