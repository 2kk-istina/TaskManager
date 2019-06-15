//
//  EntitySettings+CoreDataProperties.swift
//
//
//  Created by Истина on 12/06/2019.
//
//

import Foundation
import CoreData


extension EntitySettings {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntitySettings> {
        return NSFetchRequest<EntitySettings>(entityName: "EntitySettings")
    }
    
    @NSManaged public var notification: Bool
    @NSManaged public var sort: String?
    
}
