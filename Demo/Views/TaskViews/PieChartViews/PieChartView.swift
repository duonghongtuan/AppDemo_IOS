//
//  PieChartView.swift
//  Demo
//
//  Created by Nhung Nguyen on 18/03/2022.
//

import SwiftUI

struct PieChartView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    var body: some View {
        GeometryReader { geometry in
                    ZStack{
                        ForEach(viewModel.pieChart.slices.indices, id:\.self){ i in
                            PieSliceView(pieSliceData: viewModel.pieChart.slices[i])
                        }
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .rotationEffect(Angle.degrees(viewModel.degrees))
                        RandomButton()
                            
                    }
                    .foregroundColor(Color.white)
                }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView()
            .environmentObject(TaskViewModel())
    }
}
