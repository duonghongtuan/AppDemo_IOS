//
//  DetailTaskView.swift
//  Demo
//
//  Created by Nhung Nguyen on 17/03/2022.
//

import SwiftUI
import RealmSwift

@available(iOS 15.0, *)
struct DetailTaskView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            HStack {
                Button{
                    dismiss()
                }label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .leading)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button{
                    if(viewModel.updateTask()){
                        dismiss()
                    }
                }label: {
                    Text("Add")
                        .font(.title3)
                }
            }.padding()
            
            List{
                HStack {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .leading)
                    TextField("Cau hoi", text: $viewModel.question)
                        .font(.title2)
                    .textFieldStyle(.roundedBorder)
                }
                .padding(.vertical)
                .background(Color(.white))
                .cornerRadius(15)
               
                ForEach($viewModel.options){
                    $option in
                    OptionView(option: $option, options: $viewModel.options)
                }
                
                HStack {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .leading)
                        .foregroundColor(.blue)
                    Text("Them lua chon moi")
                    Spacer()
                }
                .padding(.vertical)
                .background(Color(.white))
                .cornerRadius(15)
                .onTapGesture {
                    let option = Option()
                    viewModel.options.append(option)
                }
                .alert(isPresented: $viewModel.showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text("Ban phai dien day du")
                        )
                    }
                Spacer()
                
            }
        }
}
}

@available(iOS 15.0, *)
struct DetailTaskView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTaskView()
            .environmentObject(TaskViewModel())
    }
}