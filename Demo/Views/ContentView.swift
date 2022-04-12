//
//  ContentView.swift
//  Demo
//
//  Created by Nhung Nguyen on 15/03/2022.
//

import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    @StateObject var viewModel = TaskViewModel()
    @EnvironmentObject var authentication: AuthenticationViewModel
    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {

        NavigationView{
            VStack {
                HStack {
                    NavigationLink{
                        HomeView()
                    }label: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .leading)
                            .foregroundColor(.gray)
                    }
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
            .alert("Important message", isPresented: $authentication.showAlert) {
                Button("OK", role: .cancel) { authentication.signOut()}
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
