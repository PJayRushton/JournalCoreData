//
//  Entry.swift
//  JournalCoreData
//
//  Created by Parker Rushton on 12/10/16.
//  Copyright © 2016 AppsByPJ. All rights reserved.
//

import Foundation
import CoreData

@objc(Entry)
class Entry: NSManagedObject, EntityDefining {
    
    @NSManaged var title: String
    @NSManaged var text: String
    @NSManaged var createdAt: Date
    @NSManaged var updatedAt: Date
    @NSManaged var journal: Journal
    
}
