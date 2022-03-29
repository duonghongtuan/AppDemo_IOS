//
//  TaskViewModel.swift
//  Demo
//
//  Created by Nhung Nguyen on 21/03/2022.
//

import Foundation
import RealmSwift

class TaskViewModel: ObservableObject{
    @Published var realmManager =  RealmManager()
    @Published var pieChart = PieChartViewModel()
    @Published var question: String = ""
    @Published var options : [Option] = []
    @Published var showAlert = false
    @Published var showAddTaskView = false
    @Published var showAddDetailTaskView = false
    @Published var id : ObjectId?
    @Published private(set) var degrees = 0.0
    @Published var option: String = ""
    @Published private(set) var timeRandom = 5
    
    init(){
        self.pieChart.createSlices(options: convertOptions(task: realmManager.tasks[0]), question: realmManager.tasks[0].question)
        self.pieChart.id = realmManager.tasks[0].id
    }
    
    func ranDomOption(){
        self.degrees += 2050
        let check = pieChart.slices[0].endAngle.degrees
        let slice = pieChart.slices.randomElement()
        let start = 360.0 - check - (slice?.startAngle.degrees)!
        let random = Int.random(in: 5..<(Int(check)-5))
        
        self.degrees = 360*5 + start + Double(random)
        
        let length = pieChart.slices.count
        var i = length - 1
        var count = 0
        let index = pieChart.slices.firstIndex(where: { $0.startAngle == slice?.startAngle })
        let time = timeRandom*1000 / (length*6 + index! + 1)
        func loop(){
            if i >= (count == 5 ? index! : 0){
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(time)) {
                    self.option = self.pieChart.slices[i].text
                    i -= 1
                    loop()
                }
            }
            if (count < 5) && (i < 0 ){
                i = length - 1
                count += 1
                loop()
            }
        }
        loop()
      
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(4000)) {
//            self.option = slice!.text
//        }
    }
    
    func createTask(question: String, options: [Option], id: ObjectId){
        self.question = question
        self.options = options
        self.id = id
    }
    
    func addTask()-> Bool{
        var check = true
        for i in options{
            if i.option == "" {
                check = false
                break
            }
        }
        if (question != "") && check {
            realmManager.addTask(question: question, options: options)
            return true
        }else{
            showAlert = true
        }
        return false
    }
    
    func updateTask() -> Bool{
        var check = true
        for i in options{
            if i.option == ""{
                check = false
                break
            }
        }
        if (question != "") && check {
            realmManager.updateTask(id: id!, question: question, options: options)
            if(id == pieChart.id){
                pieChart.createSlices(options: options, question: question)
            }
            reset()
            return true
        }else{
            showAlert = true
        }
        return false
    }
    
    func deleteTask(id : ObjectId){
        realmManager.deleteTask(id: id)
        getData()
    }
    
    func getData(){
        self.realmManager = RealmManager()
        self.pieChart = PieChartViewModel()
    }
    
    func reset(){
        question = ""
        options = []
        id = nil
        degrees = 0.0
        option = ""
    }
    
    func convertOptions(task: Task) -> [Option]{
        var options: [Option] = []
        for option in task.options{
            options.append(option)
        }
        return options
    }

    func createPieChart(task: Task){
        let x = PieChartViewModel()
        x.createSlices(options: convertOptions(task: task), question: task.question)
        x.id = task.id
        self.pieChart = x
    }
    
    func displayAddTaskView(){
        question = ""
        options = [Option(), Option()]
        id = nil
        degrees = 0.0
        option = ""
        showAddTaskView = true
    }
}
