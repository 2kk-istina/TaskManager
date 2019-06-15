//
//  EntityTask+CoreDataProperties.swift
//
//
//  Created by Истина on 12/06/2019.
//
//

import Foundation
import CoreData


extension EntityTask {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntityTask> {
        return NSFetchRequest<EntityTask>(entityName: "EntityTask")
    }
    
    @NSManaged public var dateComplete: NSDate?
    @NSManaged public var dateStart: NSDate?
    @NSManaged public var taskCategory: String?
    @NSManaged public var taskComplete: Bool
    @NSManaged public var taskText: String?
    @NSManaged public var taskTitle: String?
    @NSManaged public var categories: EntityCat?
    
}
