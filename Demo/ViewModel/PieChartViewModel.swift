//
//  PieChartViewModel.swift
//  Demo
//
//  Created by Nhung Nguyen on 21/03/2022.
//

import Foundation
import SwiftUI
import RealmSwift
let ArrayColor = [Color.green, Color.red, Color.orange, Color.yellow,  Color.blue, Color.pink, Color.purple, Color(hue: 0.649, saturation: 0.442, brightness: 0.79)]

struct PieChart{
    var id: ObjectId?
    var colors = ArrayColor
    var question: String = ""
    var slices: [PieSliceData] = []
    init(question: Question){
        createSlices(question: question)
    }
        
    mutating func createSlices(question: Question){
        
        var options: [Option] = []
        for option in question.options{
            options.append(option)
        }
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        var sum = 0.0
        for option in options {
            sum += Double(option.weight)
        }
        for (i, value) in options.enumerated() {
            let degrees: Double = Double(value.weight) * 360.0 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees:endDeg + degrees), text: value.text, color: self.colors[i]))
            endDeg += degrees
        }
        self.slices = tempSlices
        self.question = question.question
    }
}
struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}
