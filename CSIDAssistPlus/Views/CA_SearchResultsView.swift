//
//  CA_SearchResultsView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/15/24.
//

import SwiftUI

struct CA_SearchResultsView: View {
    
    @StateObject var viewModel: HomeScreenViewModel
    let columns: [GridItem] = [GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            (viewModel.activeSearch && viewModel.filteredUSDAFoodData.count > 0 ?
             LazyVGrid (columns: columns) {
                ForEach((1...viewModel.filteredUSDAFoodData.count), id: \.self) {food in
                    CA_SearchResultCellView(viewModel: viewModel, foodItem: viewModel.filteredUSDAFoodData[food-1])
                }} : nil)
        }
    }
}

#Preview {
    CA_SearchResultsView(viewModel: HomeScreenViewModel())
}
