//
//  RealmManager.swift
//  Demo
//
//  Created by Nhung Nguyen on 16/03/2022.
//

import Foundation
import RealmSwift

class RealmService: ObservableObject, Identifiable {
    private(set) var localRealm: Realm?
    @Published private(set) var questions: [Question] = []
    @Published private(set) var user : User?
    
    init(){
        openRealm()
        getQuestions()
        getUser()
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
    
    func getUser(){
        if let localRealm = localRealm {
            let user = localRealm.objects(User.self)
            if !user.isEmpty{
                self.user = user[0]
            }
           
        }
    }
    func addQuestion(question: Question){
        
        var options: [Option] = []
        for option in question.options {
            options.append(Option(_id: option._id, text: option.text, weight: option.weight))
        }
        let obj = QuestionRealm(value: ["id": question.question, "question": question.question, "createDate": question.createDate, "lastUpdate": question.lastUpdate, "userId": question.userId, "index": question.index, "options": options])
        
        
        if let localRealm = localRealm {
            do{
                try localRealm.write({
                    localRealm.add(obj)
                    getQuestions()
                    print("Add success: \(obj)")
                })
            }catch{
                print("Error add: \(error)")
            }
        }
    }
    
    func getQuestions(){
        if let localRealm = localRealm {
            let allQuestions = localRealm.objects(QuestionRealm.self)
            questions = []
            allQuestions.forEach{question in
                var options: [Option] = []
                for option in question.options {
                    options.append(Option(_id: option._id, text: option.text, weight: option.weight))
                }
                let obj = Question(_id: question._id, question: question.question, createDate: question.createDate, lastUpdate: question.lastUpdate, userId: question.userId, index: question.index, options: options)
                questions.append(obj)
            }
        }
    }
    
    func updateQuestion(id: String, question: String, options: [Option]){
        let now = Date().millisecondsSince1970
        if let localRealm = localRealm {
            do{
                let taskToUpdate = localRealm.objects(QuestionRealm.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToUpdate.isEmpty else {return}
                
                try localRealm.write {
                    taskToUpdate[0].options.removeAll()
                    for option in options {
                        let obj = OptionRealm(value: ["_id": option._id as Any, "text": option.text, "weight": option.weight])
                        taskToUpdate[0].options.append(obj)
                    }
                    taskToUpdate[0].question = question
                    taskToUpdate[0].lastUpdate = now
                    getQuestions()
                    print("update succsess")
                }
            }catch{
                print("Update error: \(error)")
            }
        }
    }
    
    func deleteQuestion(id: String) {
        if let localRealm = localRealm {
            do{
                let taskToDelete = localRealm.objects(QuestionRealm.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToDelete.isEmpty else {return}
                
                try localRealm.write {
                    localRealm.delete(taskToDelete)
                    getQuestions()
                    print("Delete succsess")
                }
            }catch{
                print("Delete error: \(error)")
            }
        }
    }
    
    func addUser(user: User){
        if let localRealm = localRealm {
            do{
                try localRealm.write({
                    localRealm.add(user)
                    getUser()
                    print("Add success: \(user)")
                })
            }catch{
                print("Error add: \(error)")
            }
        }
    }
    
    func deleteUser(){
        if let localRealm = localRealm {
            do{
                let user = localRealm.objects(User.self)
                guard !user.isEmpty else {return}
                
                try localRealm.write {
                    localRealm.delete(user)
                    print("Delete succsess")
                }
            }catch{
                print("Delete error: \(error)")
            }
        }
    }
}
