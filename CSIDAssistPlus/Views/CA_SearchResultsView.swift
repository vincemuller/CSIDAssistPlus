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
//        List {
//             ForEach((filteredUSDAFoodData), id: \.self) {food in
//                 CA_SearchResultCellView(sortingLabel: sortingLabel, foodItem: food, screenWidth: screenWidth, screenHeight: screenHeight)
//                     .frame(width: 380, height: 95)
//                    .listRowSeparator(.hidden)
//                    .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
//                    .listRowBackground(Color.white)
//                    .onTapGesture {
//                        foodDetailsPresenting = true
//                    }
//            }
//        }
//        .id(UUID())
//        .listStyle(.plain)
//        .environment(\.defaultMinListRowHeight, 0)
        
        ScrollView {
            LazyVGrid (columns: columns) {
                ForEach((filteredUSDAFoodData), id: \.self) {food in
                    CA_SearchResultCellView(foodDetailsPresenting: $foodDetailsPresenting, sortingLabel: sortingLabel, foodItem: food, screenWidth: screenWidth, screenHeight: screenHeight)
                }
            }
        }
    }
}

//#Preview {
//    CA_SearchResultsView(viewModel: HomeScreenViewModel(), screenWidth: 393, screenHeight: 759)
//}
