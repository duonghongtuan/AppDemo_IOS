//
//  RealmManager.swift
//  Demo
//
//  Created by Nhung Nguyen on 16/03/2022.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject, Identifiable {
    private(set) var localRealm: Realm?
    @Published private(set) var tasks: [Task] = []
    
    init(){
        openRealm()
        getTask()
    }
    
    func openRealm(){
        do{
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        }catch{
            print("Error opening Realm: \(error)")
        }
    }
    
    func addTask(question: String, options: [Option] ){
        if let localRealm = localRealm {
            do{
                try localRealm.write({
                    let now = Date().timeIntervalSinceReferenceDate
                    let newTask = Task(value: ["question": question, "createDate": now,"lastUpdate": 0,"options": options])
                    localRealm.add(newTask)
                    getTask()
                    print("Add success: \(newTask)")
                })
            }catch{
                print("Error add: \(error)")
            }
        }
    }
    func getTask(){
        if let localRealm = localRealm {
            let allTasks = localRealm.objects(Task.self)
            tasks = []
            allTasks.forEach{task in
                tasks.append(task)
            }
        }
    }
    
    func updateTask(id: ObjectId, question: String, options: [Option]){
        let now = Date().timeIntervalSinceReferenceDate
        if let localRealm = localRealm {
            do{
                let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToUpdate.isEmpty else {return}
                
                try localRealm.write {
                    taskToUpdate[0].options.removeAll()
                    for option in options {
                        taskToUpdate[0].options.append(option)
                    }
                    taskToUpdate[0].question = question
                    taskToUpdate[0].lastUpdate = now
                    getTask()
                    print("update succsess")
                }
            }catch{
                print("Update error: \(error)")
            }
        }
    }
    
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm {
            do{
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToDelete.isEmpty else {return}
                
                try localRealm.write {
                    localRealm.delete(taskToDelete)
                    getTask()
                    print("Delete succsess")
                }
            }catch{
                print("Delete error: \(error)")
            }
        }
    }
}
