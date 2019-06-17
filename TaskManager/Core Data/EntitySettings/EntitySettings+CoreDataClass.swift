//
//  EntitySettings+CoreDataClass.swift
//  
//
//  Created by Истина on 12/06/2019.
//
//

import Foundation
import CoreData

@objc(EntitySettings)
public class EntitySettings: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "EntitySettings"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}
