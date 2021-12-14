//
//  StorageManager.swift
//  WishListApp
//
//  Created by Ольга Горбачева on 12.12.21.
//


import CoreData
import UIKit

class StorageManager {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let shared = StorageManager()
    
    private let viewContext: NSManagedObjectContext
      
    private init() {
        
        viewContext = appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Public Methods
    

    func fetchData(completion: (Result<[Task], Error>) -> Void) {
        
        let fetchRequest = Task.fetchRequest()
        
        do {
            let tasks = try viewContext.fetch(fetchRequest)
            completion(.success(tasks))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func save(title: String, note: String, done: Bool, completion: (Task) -> Void) {
        let task = Task(context: viewContext)
        task.title = title
        task.note = note
        task.done = done
        completion(task)
        saveContext()
    }
    
    func edit(task: Task, newTitle: String, newNote: String) {
        task.title = newTitle
        task.note = newNote
        saveContext()
    }
    
    func delete(task: Task) {
        viewContext.delete(task)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

    

