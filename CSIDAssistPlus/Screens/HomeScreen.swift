//
//  HomeScreen.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/3/24.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel = HomeScreenViewModel()
    
    var body: some View {
        GeometryReader(content: { geometry in
            
            ZStack {
                Color.white
                    .ignoresSafeArea(.all)
                VStack {
                    CA_SearchBarView(viewModel: viewModel)
                        .padding(.bottom, 10)
                    CA_TopDashboardView(viewModel: viewModel)
                        .padding(.bottom, 20)
                    CA_SearchResultsView(viewModel: viewModel)
                    (viewModel.activeSearch ? nil : Spacer())
                }
            }
            .overlay (alignment: .bottom) {
                CA_AddButtonView(viewModel: viewModel)
            }.onAppear {
                viewModel.screenWidth = geometry.size.width
                viewModel.screenHeight = geometry.size.height
                databasePointer = CA_DatabaseHelper.getDatabasePointer(databaseName: "CSIDAssistFoodDatabase2.db")
            }
        }).ignoresSafeArea(.keyboard)
    }
}

#Preview {
    HomeScreen()
}


