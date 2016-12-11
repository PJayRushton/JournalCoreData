//
//  Journal.swift
//  JournalCoreData
//
//  Created by Parker Rushton on 12/10/16.
//  Copyright © 2016 AppsByPJ. All rights reserved.
//

import Foundation
import CoreData

protocol EntityDefining { }

extension EntityDefining {
    static var entityName: String {
        return String(describing: self.self)
    }
    
    func save() {
        Stack.shared.save()
    }
    
}

@objc(Journal)
class Journal: NSManagedObject, EntityDefining {
    
    @NSManaged var title: String
    @NSManaged var createdAt: Date
    @NSManaged var updatedAt: Date
    @NSManaged var entries: NSOrderedSet
    
    func addEntry(with title: String) -> Entry? {
        return CoreDataHelper.shared.addEntry(to: self, title: title)
    }
}
