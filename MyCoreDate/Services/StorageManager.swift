//
//  StorageManager.swift
//  MyCoreDate
//
//  Created by Aleksandr Rybachev on 19.04.2022.
//


import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    // MARK: - Core Data stack
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyCoreDate")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Methods for VC
    
    func fetchData() -> [CoreTask] {
        let fetchRequest = CoreTask.fetchRequest()
        do {
            let taskList = try context.fetch(fetchRequest)
            return taskList
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func saveTask(_ task: CoreTask) {
        context.insert(task)
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteTask(_ task: CoreTask) {
        context.delete(task)
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
