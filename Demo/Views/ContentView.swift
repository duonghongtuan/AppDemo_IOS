//
//  ContentView.swift
//  Demo
//
//  Created by Nhung Nguyen on 15/03/2022.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    var screenWidth = UIScreen.main.bounds.width
    var body: some View {

        NavigationView{
            VStack {
                HStack {
                    Spacer()
                    NavigationLink{
                        TaskView()
                            .environmentObject(viewModel)
                    }label: {
                            Image(systemName: "list.bullet")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .leading)
                                .foregroundColor(.gray)
                    }
                    
                }
                .padding()
                Text(viewModel.pieChart.question)
                    .font(.title2)
                    .foregroundColor(.gray)
                Text(viewModel.option != "" ?viewModel.option:"???")
                    .font(.title)
                Spacer()
                PieChartView()
                    .environmentObject(viewModel)
                    .foregroundColor(.green)
                    .frame(width: screenWidth, height: screenWidth)
                Button{
                    viewModel.reset()
                }label: {
                    Text("Dat lai banh xe")
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
        
    }


}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TaskViewModel())
    }
}
