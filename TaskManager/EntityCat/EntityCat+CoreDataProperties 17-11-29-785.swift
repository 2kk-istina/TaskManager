//
//  EntityCat+CoreDataProperties.swift
//
//
//  Created by Истина on 12/06/2019.
//
//

import Foundation
import CoreData

extension EntityCat {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntityCat> {
        return NSFetchRequest<EntityCat>(entityName: "EntityCat")
    }
    @NSManaged public var colour: NSObject?
    @NSManaged public var name: String?
    @NSManaged public var catTask: NSSet?
}

// MARK: Generated accessors for catTask
extension EntityCat {
    @objc(addCatTaskObject:)
    @NSManaged public func addToCatTask(_ value: EntityTask)
    @objc(removeCatTaskObject:)
    @NSManaged public func removeFromCatTask(_ value: EntityTask)
    @objc(addCatTask:)
    @NSManaged public func addToCatTask(_ values: NSSet)
    @objc(removeCatTask:)
    @NSManaged public func removeFromCatTask(_ values: NSSet)
}
