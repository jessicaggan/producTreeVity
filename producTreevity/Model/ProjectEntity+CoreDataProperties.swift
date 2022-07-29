//
//  ProjectEntity+CoreDataProperties.swift
//  producTreevity
//
//  Created by Jessica Geofanie on 29/07/22.
//
//

import Foundation
import CoreData


extension ProjectEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectEntity> {
        return NSFetchRequest<ProjectEntity>(entityName: "ProjectEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var projectCreatedDate: String?
    @NSManaged public var projectImageType: String?
    @NSManaged public var projectName: String?
    @NSManaged public var finishedTask: Int16
    @NSManaged public var tasks: Set<TaskEntity>?
    
    public var task:[TaskEntity]{
        let setTask = tasks
        
        return setTask!.sorted{
            $0.id > $1.id
        }
    }

}

// MARK: Generated accessors for tasks
extension ProjectEntity {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: TaskEntity)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: TaskEntity)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension ProjectEntity : Identifiable {

}
