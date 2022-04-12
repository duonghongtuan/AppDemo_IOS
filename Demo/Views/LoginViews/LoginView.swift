//
//  LoginView.swift
//  Demo
//
//  Created by Nhung Nguyen on 25/03/2022.
//

import SwiftUI

struct LoginView: View {

  // 1
  @EnvironmentObject var viewModel: AuthenticationViewModel

  var body: some View {
    VStack {
      Spacer()

      // 2

      Text("Welcome to DemoApp")
        .fontWeight(.black)
        .foregroundColor(Color(.systemIndigo))
        .font(.largeTitle)
        .multilineTextAlignment(.center)

      Spacer()
        Button{
            viewModel.signIn()
        }label: {
            Text("Login with google")
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(12)
                .padding()
        }
        .padding()
    }
  }
}
