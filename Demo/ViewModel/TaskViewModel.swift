//
//  TaskViewModel.swift
//  Demo
//
//  Created by Nhung Nguyen on 21/03/2022.
//

import Foundation
import RealmSwift
import Alamofire
import Combine

let x = Option(_id: "1", text: "1", weight: 1)
let y = Option(_id: "2", text: "2", weight: 1)

let obj = Question(question: "Abc", createDate: 1647316585000, lastUpdate: 1647316585000, userId: "", index: 1, options: [x,y])
class TaskViewModel: ObservableObject{
    var realmManager : RealmService
    var apiService : ApiService
    @Published var questions = [Question]()
    @Published var pieChart : PieChart
    @Published var question: String = ""
    @Published var options : [Option] = []
    @Published var showAlert = false
    @Published var showAddTaskView = false
    @Published var showAddDetailTaskView = false
    @Published var id : String = ""
    @Published private(set) var degrees = 0.0
    @Published var option: String = ""
    @Published private(set) var timeRandom = 5
    
    init( realmService: RealmService = RealmService(), apiService: ApiService = ApiService()){
        self.realmManager = realmService
        self.apiService = apiService
        self.pieChart = PieChart(question: obj)
        getQuestions()
    }
    
    func getQuestions(){
        print("getqs")
        apiService.apiQuestion.getAllQuestions(userId: realmManager.user!.userId){
            data in
            self.questions = data
        }
    }
    
    func ranDomOption(){
        getQuestions()
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
      
    }
    
    func createTask(question: String, options: [Option], id: String){
        self.question = question
        self.options = options
        self.id = id
    }
    
    func addTask(){
        var check = true
        for i in options{
            if i.text == "" {
                check = false
                break
            }
        }
        if (question != "") && check {
            let index = questions.count + 1
            
            let now = Date().millisecondsSince1970
            
            let newQuestion = Question(question: question, createDate: now,lastUpdate: now,userId: realmManager.user!.userId,index: index ,options: options)
            
            realmManager.addQuestion( question: newQuestion)
            
            showAddTaskView = false
            
            questions.append(newQuestion)
            
//            apiService.apiQuestion.addQuestion(question: newQuestion)
            }else{
            showAlert = true
        }
    }
    
    func updateTask() -> Bool{
        var check = true
        for i in options{
            if i.text == ""{
                check = false
                break
            }
        }
        if (question != "") && check {
            realmManager.updateQuestion(id: id, question: question, options: options)
//            if(id == pieChart.id){
//                pieChart.createSlices(options: options, question: question)
//            }
            reset()
            return true
        }else{
            showAlert = true
        }
        return false
    }
    
    func deleteQuestion(id : String, index: Int){
        questions.remove(at: index)
        realmManager.deleteQuestion(id: id)
        getData()
    }
    
    func getData(){
//        self.realmManager = RealmService()
//        self.pieChart = PieChartViewModel()
    }
    
    func reset(){
        question = ""
        options = []
        id = ""
        degrees = 0.0
        option = ""
    }
    
    func convertOptions(task: QuestionRealm) -> [OptionRealm]{
        var options: [OptionRealm] = []
        for option in task.options{
            options.append(option)
        }
        return options
    }

    func createPieChart(task: QuestionRealm){
//        let x = PieChartViewModel()
//        x.createSlices(options: convertOptions(task: task), question: task.question)
//        x.id = task.id
//        self.pieChart = x
    }
    
    func displayAddTaskView(){
        reset()
        options = [Option(text:""), Option(text:"")]
        showAddTaskView = true
    }
}
