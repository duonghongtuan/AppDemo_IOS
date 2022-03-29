//
//  TabView.swift
//  Demo
//
//  Created by Nhung Nguyen on 22/03/2022.
//

import SwiftUI

@available(iOS 15.0, *)
struct TabItem: View {
    init(){
        UITabBar.appearance().barTintColor = .systemBackground
    }
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "questionmark.circle")
                }

            GestureView()
                .tabItem {
                    Image(systemName: "hand.point.up")
                }
            RandomView()
                .tabItem {
                    Image(systemName: "r.square")
                }
        }
    }
}

@available(iOS 15.0, *)
struct TabItem_Previews: PreviewProvider {
    static var previews: some View {
        TabItem()
    }
}
