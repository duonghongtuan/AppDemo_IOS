//
//  PieChartViewModel.swift
//  Demo
//
//  Created by Nhung Nguyen on 21/03/2022.
//

import Foundation
import SwiftUI
import RealmSwift

class PieChartViewModel: ObservableObject{
    @Published var id: ObjectId?
    @Published var colors: [Color]
    @Published var question: String = ""
    @Published var slices: [PieSliceData] = []
    init(){
        let arrayColor = [Color.green, Color.red, Color.orange, Color.yellow,  Color.blue, Color.pink, Color.purple, Color(hue: 0.649, saturation: 0.442, brightness: 0.79)]
        self.colors = arrayColor
    }
    
    
    
    
    func createSlices(options: [Option], question: String){
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        var sum = 0.0
        for option in options {
            sum += Double(option.weight)
        }
        for (i, value) in options.enumerated() {
            let degrees: Double = Double(value.weight) * 360.0 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees:endDeg + degrees), text: value.option, color: self.colors[i]))
            endDeg += degrees
        }
        self.slices = tempSlices
        self.question = question
    }
}
struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}
