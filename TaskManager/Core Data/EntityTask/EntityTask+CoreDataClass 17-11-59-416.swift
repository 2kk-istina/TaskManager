//
//  EntityTask+CoreDataClass.swift
//  
//
//  Created by Истина on 12/06/2019.
//
//

import Foundation
import CoreData

@objc(EntityTask)
public class EntityTask: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "EntityTask"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}
