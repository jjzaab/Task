//
//  TaskController.swift
//  Task
//
//  Created by XMS_JZhan on 1/30/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    // Singleton
    static let shared = TaskController()
    
    // Source of truth
    let fetchResultsController: NSFetchedResultsController<Task> = {
        let fetchedRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let isCompleteSort = NSSortDescriptor(key: "isComplete", ascending: true)
        let dueSort = NSSortDescriptor(key: "due", ascending: true)
        fetchedRequest.sortDescriptors = [isCompleteSort, dueSort]
        return NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
    }()
    
    init() {
        do {
            try fetchResultsController.performFetch()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    // Mock Data
    var mockData: [Task] {
        let taskOne = Task(name: "First", notes: "ABC", due: Date())
        taskOne.isComplete = true
        let taskTwo = Task(name: "Second", notes: nil, due: Date())
        let taskThree = Task(name: "Third", notes: nil, due: nil)
        return [taskOne, taskTwo, taskThree]
    }
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        if CoreDataStack.context.hasChanges {
            do {
                try CoreDataStack.context.save()
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}
