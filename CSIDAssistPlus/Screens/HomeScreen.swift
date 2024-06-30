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
                    CA_CalendarDashboardView(viewModel: viewModel)
                        .padding(.bottom, 20)
                    (viewModel.expandSearch ? nil :
                        HStack (spacing: 20) {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.caTurqBlue, lineWidth: 3)
                            .frame(width: viewModel.screenWidth/2.4, height: viewModel.screenHeight * 0.197)
                            .overlay(alignment: .center) {
                                Image("hipsterAnimal")
                                    .resizable()
                                    .frame(width: 140, height: viewModel.activeSearch ? 0 : 140)
                                    .offset(y: 20)
                                    .mask {
                                        RoundedRectangle(cornerRadius: 30)
                                            .frame(width: viewModel.screenWidth/2.4, height: viewModel.screenHeight * 0.197)
                                    }
                            }
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.caTurqBlue.opacity(0.2))
                            .frame(width: viewModel.screenWidth/2.4, height: viewModel.screenHeight * 0.197)
                    })
                    CA_SearchResultsView(viewModel: viewModel)
                }
            }
            .overlay (alignment: .bottom) {
                CA_AddButtonView(viewModel: viewModel)
            }.onAppear {
                viewModel.screenWidth = geometry.size.width
                viewModel.screenHeight = geometry.size.height
                databasePointer = CA_DatabaseHelper.getDatabasePointer(databaseName: "CSIDAssistFoodDatabase2.db")
            }
            .overlay {
                viewModel.inProgress ?
                ZStack {
                    Color.black.opacity(0.01)
                        .ignoresSafeArea(.all)
                    CA_ProgressBarView()
                        
                }
                : nil
            }
        }).ignoresSafeArea(.keyboard)
    }
}

#Preview {
    HomeScreen()
}


