//
//  CA_DailyNutsView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 8/11/24.
//

import SwiftUI

struct CA_DailyNutsView: View {
//    @StateObject var viewModel: HomeScreenViewModel
    @State var dailyNuts: [DailyNutData]
    
    var screenWidth: CGFloat
    var screenHeight: CGFloat
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(dailyNuts) { nut in
                CA_DailyNutIndividualView(label: nut.label, nutData: nut.nutData)
            }
        }.frame(width: screenWidth/2.4, height: screenHeight * 0.197)
    }
}

#Preview {
    CA_DailyNutsView(dailyNuts: [DailyNutData(label: "Total Carbs", nutData: "25.0g"),DailyNutData(label: "Net Carbs", nutData: "20.0g"),DailyNutData(label: "Total Sugars", nutData: "12.0g"),DailyNutData(label: "Total Starches", nutData: "8.0g")], screenWidth: 393, screenHeight: 759)
}
