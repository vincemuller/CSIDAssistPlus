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
                CA_SearchResultCellView(viewModel: viewModel,
                                        fdicID: viewModel.filteredUSDAFoodData[food-1].fdicID,
                                        brandOwner: viewModel.filteredUSDAFoodData[food-1].brandOwner?.description ?? "",
                                        brandName: viewModel.filteredUSDAFoodData[food-1].brandName?.description ?? "",
                                        category: viewModel.filteredUSDAFoodData[food-1].brandedFoodCategory.description,
                                        description: viewModel.filteredUSDAFoodData[food-1].description,
                                        carbs: viewModel.filteredUSDAFoodData[food-1].carbs.description,
                                        totalSugars: viewModel.filteredUSDAFoodData[food-1].totalSugars,
                                        totalStarchs: viewModel.filteredUSDAFoodData[food-1].totalStarches)
            } : nil)
        }
    }
}

#Preview {
    CA_SearchResultsView(viewModel: HomeScreenViewModel())
}
