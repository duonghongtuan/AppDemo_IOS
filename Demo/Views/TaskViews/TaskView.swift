//
//  TaskView.swift
//  Demo
//
//  Created by Nhung Nguyen on 16/03/2022.
//

import SwiftUI

@available(iOS 15.0, *)
struct TaskView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List{
                ForEach(viewModel.questions, id: \._id){
                    task in
                        let i = viewModel.questions.firstIndex(where: {$0._id == task._id})
                        TaskRow(question: task.question, index: i!)
                            .environmentObject(viewModel)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    viewModel.deleteQuestion(id: task._id!, index: i!)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
            }
            
        }
            SmallAddButton()
                .padding()
                .onTapGesture {
                    viewModel.displayAddTaskView()                }
        }
        .sheet(isPresented: $viewModel.showAddTaskView){
                AddTaskView()
                    .environmentObject(viewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
}
}

@available(iOS 15.0, *)
struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
            .environmentObject(TaskViewModel())
    }
}
