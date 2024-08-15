//
//  CA_SearchResultsView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/15/24.
//

import SwiftUI

struct CA_SearchResultsView: View {
    @Binding var filteredUSDAFoodData: [newUSDAFoodDetails]
    @Binding var foodDetailsPresenting: Bool
    var sortingLabel: String
    
    let columns: [GridItem] = [GridItem(.flexible())]
    var screenWidth: CGFloat
    var screenHeight: CGFloat
    
    var body: some View {
        List {
             ForEach((filteredUSDAFoodData), id: \.self) {food in
                 CA_SearchResultCellView(sortingLabel: sortingLabel, foodItem: food, screenWidth: screenWidth, screenHeight: screenHeight)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                    .listRowBackground(Color.white)
                    .onTapGesture {
                        foodDetailsPresenting = true
                    }
            }
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 0)
        
//        ScrollView {
//            (viewModel.activeSearch && !viewModel.filteredUSDAFoodData.isEmpty ?
//             LazyVGrid (columns: columns) {
//                ForEach((viewModel.filteredUSDAFoodData), id: \.self) {food in
//                    CA_SearchResultCellView(viewModel: viewModel, foodItem: food)
//                }} : nil)
//        }
    }
}

//#Preview {
//    CA_SearchResultsView(viewModel: HomeScreenViewModel(), screenWidth: 393, screenHeight: 759)
//}
