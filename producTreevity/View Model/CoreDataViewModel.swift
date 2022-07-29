//
//  CoreDataModel.swift
//  producTreevity
//
//  Created by Jessica Geofanie on 27/07/22.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container:NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
            else{
                print("Core Data loaded successfully")
            }
        }
        context = container.viewContext
    }
    
    func save(){
        do{
            try context.save()
            print("Saving success")
        }catch let error{
            print("Error saving Core Data. \(error)")
        }
    }
}
class CoreDataViewModel: ObservableObject{
    let manager = CoreDataManager.instance
    @Published var projects:[ProjectEntity] = []
    @Published var tasks:[TaskEntity] = []
    
    init(){
        getTasks()
        getProjects()
    }
    func save(){
        manager.save()
    }
    
    func createProject(name:String,imageNameType:String) -> ProjectEntity{
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        
        let project = ProjectEntity(context: manager.context)
        project.projectName = name
        project.projectCreatedDate = dateString
        project.projectImageType = imageNameType
        print(projects.count)
        save()
        return project
    }
    
    func addTask(taskName:String){
        let task = TaskEntity(context: manager.context)
        task.taskName = taskName
        save()
    }
    func createTask(taskName:String, taskProgress:String, projectEntity:ProjectEntity)  {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        
        let task = TaskEntity(context: manager.context)
        task.taskName = taskName
        task.taskProgress = taskProgress
        task.taskUpdateDate = dateString
        task.projects = projectEntity
        projectEntity.addToTasks(task)
        
//        let idx = projects.count - 1
//        print(projects[idx].projectName)
//        print(projects[idx-1].tasks)
//        task.projects = projects[idx]
//        print(projects[idx].tasks)
        save()
    }
    
    func getProjects(){
        let request = NSFetchRequest<ProjectEntity>(entityName: "ProjectEntity")
        do {
            projects = try manager.context.fetch(request)
        } catch let error{
            print("Error Fetching. \(error)")
        }
        
    }
    
    func getTasks(){
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        
        do {
            tasks =  try manager.context.fetch(request)
        } catch let error{
            print("Error Fetching. \(error)")
        }
    }
    
    func updateProgress(project:ProjectEntity,task:TaskEntity, progress:String, progressBefore:String){
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        
        task.taskProgress = progress
        if progress == "Finished" && progressBefore != "Finished"{
            project.finishedTask+=1
//            print(project.finishedTask)
        }
        else if progressBefore == "Finished" && progress != "Finished"{
            project.finishedTask -= 1
        }
        else if progress != "Finished"{
            project.finishedTask = project.finishedTask
        }
        task.taskUpdateDate = dateString
        save()
    }
    
    func saveData(){
//        projects.removeAll()
//        tasks.removeAll()
//
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ){
            self.manager.save()
            self.getProjects()
            self.getTasks()
        }
    }
}
    
