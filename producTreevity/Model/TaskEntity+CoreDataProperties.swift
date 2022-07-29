//
//  TaskEntity+CoreDataProperties.swift
//  producTreevity
//
//  Created by Jessica Geofanie on 29/07/22.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var taskName: String?
    @NSManaged public var taskProgress: String?
    @NSManaged public var taskUpdateDate: String?
    @NSManaged public var projects: ProjectEntity?

}

extension TaskEntity : Identifiable {

}
