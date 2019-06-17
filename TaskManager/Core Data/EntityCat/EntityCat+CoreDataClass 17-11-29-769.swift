//
//  EntityCat+CoreDataClass.swift
//  
//
//  Created by Истина on 12/06/2019.
//
//

import Foundation
import CoreData

@objc(EntityCat)
public class EntityCat: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "EntityCat"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}
