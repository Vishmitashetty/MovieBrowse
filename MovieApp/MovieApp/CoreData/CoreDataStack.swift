//
//  CoreDataStack.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 25/04/21.
//


import Foundation
import CoreData

class CoreDataStack {
    private let modelName: String
    static let shared = CoreDataStack()
    
    private init(modelName: String = "MovieApp") {
        self.modelName = modelName
    }
    
    private lazy var storeContainer: NSPersistentContainer = { [unowned self] in
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint("error: \(error.localizedDescription)")
            }
        }
        return container
        
    }()
    
    lazy var managedContext: NSManagedObjectContext = { [unowned self] in
        self.storeContainer.viewContext
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            debugPrint(error)
        }
    }
}
