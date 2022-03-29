//
//  GestureView.swift
//  Demo
//
//  Created by Nhung Nguyen on 22/03/2022.
//

import SwiftUI

struct GestureView: View {
    @State var location: CGPoint = .zero
    @GestureState var press = false
    @State var dragPress = false
    @State var hiden = true
    
    var dragePress: some Gesture{
        DragGesture(minimumDistance: 0)
            .onChanged{value in
                self.location = value.location
                hiden = false
                withAnimation(.linear(duration: 0.9).repeatForever(autoreverses: false)){
                    dragPress = true
                }
            }
            .simultaneously(with: newGesture)
            .onEnded {_ in
                dragPress = false
                hiden = true
            
            }
    }
    
    let newGesture = TapGesture().onEnded {
            print("Gesture on VStack.")
        }
    
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    
                hiden ? nil : ZStack {
                    Circle()
                        .fill(dragPress == false ? Color(red: 0.101, green: 0.477, blue: 0.998, opacity: 0.605) : Color("AccentColor"))
                        .frame(width: 100, height: 100, alignment: .center)
                        .scaleEffect(dragPress ? 2 : 1)
                        .position(location)
                    
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 100, height: 100, alignment: .center)
                        .position(location)
                }
                
            }
            .gesture(dragePress)
        }
}

struct GestureView_Previews: PreviewProvider {
    static var previews: some View {
        GestureView()
    }
}
