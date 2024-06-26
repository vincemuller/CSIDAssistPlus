//
//  CA_SearchResultsView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/15/24.
//

import SwiftUI

struct CA_SearchResultsView: View {
    
    @StateObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        ScrollView {
            (viewModel.activeSearch && viewModel.filteredUSDAFoodData.count > 0 ? ForEach((1...viewModel.filteredUSDAFoodData.count), id: \.self) {food in
                CA_SearchResultCellView(viewModel: viewModel, description: viewModel.filteredUSDAFoodData[food-1].description)
            } : nil)
        }
    }
}

#Preview {
    CA_SearchResultsView(viewModel: HomeScreenViewModel())
}
