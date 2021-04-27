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
    
    //Insert recent search in coredata unique identifer is movie id
    func insertRecentSearches(movie: Movie) {
        LoggerRepository.shared.dbDebugging(entityName: RecentSearches.entityName, operationName: LoggerRepository.DBOperations.insert.rawValue)
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
                        LoggerRepository.shared.dbOperationSuccess(entityName: RecentSearches.entityName, operationName: LoggerRepository.DBOperations.insert.rawValue)
                    } catch {
                        LoggerRepository.shared.dbOperationFailure(entityName: RecentSearches.entityName, operationName: LoggerRepository.DBOperations.insert.rawValue, message: error.localizedDescription)
                    }
                }
            } catch {
                LoggerRepository.shared.dbOperationFailure(entityName: RecentSearches.entityName, operationName: LoggerRepository.DBOperations.insert.rawValue, message: error.localizedDescription)
            }
        }
    }
}
