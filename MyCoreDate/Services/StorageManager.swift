//
//  StorageManager.swift
//  MyCoreDate
//
//  Created by Aleksandr Rybachev on 19.04.2022.
//


import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyCoreDate")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let context: NSManagedObjectContext
    
    private init() {
        context = persistentContainer.viewContext
    }

    // MARK: - CRUD
    // Create, Read, Update, Delete
    
    func fetchData(completion: (Result<[CoreTask], Error>) -> Void) {
        let fetchRequest = CoreTask.fetchRequest()
        
        do {
            let tasks = try self.context.fetch(fetchRequest)
            completion(.success(tasks))
        } catch {
            completion(.failure(error))
        }
    }
    
    func create(_ taskName: String, completion: (CoreTask) -> Void) {
        let task = CoreTask(context: context)
        task.title = taskName
        completion(task)
        saveContext()
    }
    
    func update(_ task: CoreTask, newName: String) {
        task.title = newName
        saveContext()
    }
    
    func delete(_ task: CoreTask) {
        context.delete(task)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
