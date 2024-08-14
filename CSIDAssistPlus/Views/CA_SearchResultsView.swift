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
        List {
            (viewModel.getActiveSearchState() ?
             ForEach((viewModel.getFilteredUSDAFoodData()), id: \.self) {food in
                CA_SearchResultCellView(viewModel: viewModel, foodItem: food).listRowSeparator(.hidden).listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            } : nil)
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

#Preview {
    CA_SearchResultsView(viewModel: HomeScreenViewModel())
}
