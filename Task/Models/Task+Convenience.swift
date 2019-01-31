//
//  Task+Convenience.swift
//  Task
//
//  Created by XMS_JZhan on 1/30/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    @discardableResult
    convenience init(name: String, notes: String?, due: Date?, managedObjectContext: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: managedObjectContext)
        self.name = name
        self.notes = notes
        self.due = due

    }
    
}
