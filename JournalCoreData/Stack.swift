//
//  Stack.swift
//
import Foundation
import CoreData

class Stack {
    
    static let shared = Stack()
    
    lazy var managedObjectContext: NSManagedObjectContext = Stack.setUpMainContext()
    
    static func setUpMainContext() -> NSManagedObjectContext {
        let mainBundle = Bundle.main
        guard let model = NSManagedObjectModel.mergedModel(from: [mainBundle]) else {
            fatalError("model not found")
        }
        let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = storeCoordinator
        
        return context
    }
    
    static var storeURL: URL? {
        let documentsDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return documentsDirectory?.appendingPathComponent("db.sqlite")
    }
    
    func save() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
}

struct CoreDataStack {
    
    static let shared = CoreDataStack()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "JournalCoreData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error), \(error)")
            }
        }
        return container
    }()
    
    mutating func managedObjectContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    
    mutating func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Unresolved error \(error)")
            }
        }
    }

}
