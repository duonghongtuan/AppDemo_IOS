//
//  OptionView.swift
//  Demo
//
//  Created by Nhung Nguyen on 16/03/2022.
//

import SwiftUI

struct OptionView: View {
    @Binding var option: Option
    @Binding var options: [Option]
    var body: some View {
        HStack {
            Image(systemName: "minus.circle.fill")
                .resizable()
                .frame(width: 20, height: 20, alignment: .leading)
                .foregroundColor(.red)
                .onTapGesture {
                    let i = options.firstIndex( where: {$0._id == option._id})
                    options.remove(at: i!)
                    
                }
            TextField("Lua chon", text: $option.text)
            Spacer()
        }
        .padding(.vertical)
        .background(Color(.white))
        .cornerRadius(15)
    }
}

struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        let option = Option(text: "")
        OptionView(option: .constant(option), options: .constant([option]))
    }
}
