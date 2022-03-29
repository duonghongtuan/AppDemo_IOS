//
//  PieSliceView.swift
//  Demo
//
//  Created by Nhung Nguyen on 18/03/2022.
//

import SwiftUI

struct PieSliceView: View {
    var pieSliceData: PieSliceData
    var midRadians: Double {
            return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
        }
    var degrees: Double{
        return pieSliceData.startAngle.degrees - 90.0 + (pieSliceData.endAngle - pieSliceData.startAngle).degrees / 2.0
    }
    var screenWidth = UIScreen.main.bounds.width
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                            let width: CGFloat = min(geometry.size.width, geometry.size.height)
                            let height = width
                            
                            let center = CGPoint(x: width * 0.5, y: height * 0.5)
                            
                            path.move(to: center)
                            
                            path.addArc(
                                center: center,
                                radius: width * 0.5,
                                startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
                                endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
                                clockwise: false)
                            
                        }
                .fill(pieSliceData.color)
                HStack {
                    Text(pieSliceData.text)
                        .foregroundColor(Color("AccentColor"))
                        .frame(width: screenWidth/2)
                        .font(.title3)
                    Text(pieSliceData.text)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.trailing)
                        .frame(width: screenWidth/2 - 50)
                        .font(.title3)
                                    
                }
                
                .rotationEffect(Angle.degrees(degrees))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
}

struct PieSliceView_Previews: PreviewProvider {
    static var previews: some View {
        PieSliceView(pieSliceData: PieSliceData(
                              startAngle: Angle(degrees:80.0),
                              endAngle: Angle(degrees: 200.0), text: "Gi cung duoc phai khong ban oi",
                              color: Color.black))
    }
}
