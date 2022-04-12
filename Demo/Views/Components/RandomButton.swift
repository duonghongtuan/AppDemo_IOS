//
//  RandomButton.swift
//  Demo
//
//  Created by Nhung Nguyen on 22/03/2022.
//

import SwiftUI

struct RandomButton: View {
    @EnvironmentObject var viewModel: TaskViewModel
    var body: some View {
        ZStack(alignment: .top) {
            ZStack {
                Circle()
                    .frame(width: 90)
                .foregroundColor(.gray)
                Circle()
                    .strokeBorder(Color.blue, lineWidth: 2)
                    .frame(width: 50)
                    .background(Circle().foregroundColor(Color.white))
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        viewModel.reset()
                        withAnimation(.easeOut(duration: Double(viewModel.timeRandom))) {
                            viewModel.ranDomOption()
                            }
                    }
            }
            
            Image(systemName: "triangle.fill" )
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundColor(.gray)
        }
        .frame(width: 110, height: 110)
    }
}

struct RandomButton_Previews: PreviewProvider {
    static var previews: some View {
        RandomButton()
    }
}
