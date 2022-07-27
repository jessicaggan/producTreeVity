//
//  CoreDataModel.swift
//  producTreevity
//
//  Created by Jessica Geofanie on 27/07/22.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject{
    let container:NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "Project")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
            else{
                print("Core Data loaded successfully")
            }
        }
    }
}
    
