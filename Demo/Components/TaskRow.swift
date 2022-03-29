//
//  TaskRow.swift
//  Demo
//
//  Created by Nhung Nguyen on 16/03/2022.
//

import SwiftUI

@available(iOS 15.0, *)
struct TaskRow: View {
    @EnvironmentObject var viewModel: TaskViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var question: String
    var index : Int
    
    var body: some View {
        HStack {
            Text(question)
                .font(.title2)
            Spacer()
            Image(systemName: "pencil")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
                .onTapGesture {
                    let task = viewModel.realmManager.tasks[index]
                    viewModel.createTask(question: question, options: viewModel.convertOptions(task: task), id: task.id)
                    viewModel.showAddDetailTaskView.toggle()
                }

            
        }
        .sheet(isPresented: $viewModel.showAddDetailTaskView){
            DetailTaskView()
                .environmentObject(viewModel)
        }
        .onTapGesture {
            let task = viewModel.realmManager.tasks[index]
            viewModel.reset()
            viewModel.createPieChart(task: task)
            self.presentationMode.wrappedValue.dismiss()
        }
        .frame(maxWidth: .infinity, alignment:
                    .leading)
    }
}

@available(iOS 15.0, *)
struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(question: "Toi nay an gi?", index: 0)
            .environmentObject(TaskViewModel())
    }
}
