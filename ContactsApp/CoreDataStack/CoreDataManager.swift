//
//  ContactsPersistancyManager.swift
//  ContactsApp
//
//  Created by Gudkesh Kumar on 20/12/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    private var model: String
    
   private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: model)
        container.loadPersistentStores { (_, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error {
                fatalError("Unable to load persistentStore: \(error)")
            }
        }
        return container
    }()
    
    
    init(with model: String) {
        self.model = model
    }
    
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        storeContainer.performBackgroundTask(block)
    }

    func performViewTask( _ block:  @escaping (NSManagedObjectContext) -> Void) {
        block(storeContainer.viewContext)
    }
}
