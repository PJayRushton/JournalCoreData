//
//  CoreDataHelper.swift
//  JournalCoreData
//
//  Created by Parker Rushton on 12/10/16.
//  Copyright © 2016 AppsByPJ. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataHelper {
    
    static let shared = CoreDataHelper()
    let context = Stack.shared.managedObjectContext
    
    func addJournal(title: String) -> Journal? {
        if let journal = NSEntityDescription.insertNewObject(forEntityName: Journal.entityName, into: context) as? Journal {
            journal.title = title
            journal.createdAt = Date()
            journal.updatedAt = Date()
            journal.save()
            
            return journal
        } else {
            return nil
        }
    }
    
    func addEntry(to journal: Journal, title: String) -> Entry? {
        if let entry = NSEntityDescription.insertNewObject(forEntityName: Entry.entityName, into: context) as? Entry {
            entry.journal = journal
            entry.title = title
            entry.createdAt = Date()
            entry.updatedAt = Date()
            entry.save()
            
            return entry
        } else {
            return nil
        }
    }
    
    func getJournals() -> [Journal] {
        let request = NSFetchRequest<Journal>(entityName: String(describing: Journal.self))
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
}
