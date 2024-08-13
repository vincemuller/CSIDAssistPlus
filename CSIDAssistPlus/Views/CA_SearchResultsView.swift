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
            (viewModel.activeSearch && !viewModel.filteredUSDAFoodData.isEmpty ?
             LazyVGrid (columns: columns) {
                ForEach((viewModel.filteredUSDAFoodData), id: \.fdicID) {food in
                    CA_SearchResultCellView(viewModel: viewModel, foodItem: food)
                }} : nil)
        }
    }
}

#Preview {
    CA_SearchResultsView(viewModel: HomeScreenViewModel())
}
