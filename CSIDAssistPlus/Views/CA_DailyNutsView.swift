//
//  CA_DailyNutsView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 8/11/24.
//

import SwiftUI

struct CA_DailyNutsView: View {
    @StateObject var viewModel: HomeScreenViewModel
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())]
    
    var body: some View {
        viewModel.expandSearch ? nil :
        LazyVGrid(columns: columns) {
            ForEach(viewModel.dailyNuts) { nut in
                CA_DailyNutIndividualView(label: nut.label, nutData: nut.nutData)
            }
        }.frame(width: viewModel.screenWidth/2.4, height: viewModel.screenHeight * 0.197)
    }
}

#Preview {
    CA_DailyNutsView(viewModel: HomeScreenViewModel())
}
