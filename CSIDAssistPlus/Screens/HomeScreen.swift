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
            NavigationStack {
                ZStack {
                    Color.white
                        .ignoresSafeArea(.all)
                    VStack {
                        CA_SearchBarView(viewModel: viewModel)
                            .padding(.top, 5)
                            .padding(.bottom, 10)
                        CA_TopDashboardView(viewModel: viewModel)
                            .padding(.bottom, viewModel.activeSearch ? 15 : 10)
                        CA_CalendarDashboardView(viewModel: viewModel)
                            .padding(.bottom, 20)
                        HStack (spacing: 15) {
                            CA_HipsterEncouragementView(viewModel: viewModel)
                            CA_DailyNutsView(viewModel: viewModel)
                        }
                        CA_SearchResultsView(viewModel: viewModel)
                            .padding(.top, 15)
                    }
                    NavigationLink(destination: CA_AddNewMealScreen()) {
                        viewModel.expandSearch ? nil :
                        CA_AddButtonView(viewModel: viewModel)
                    }.offset(y: 350)
                }
                .onAppear {
                    viewModel.screenWidth   = geometry.size.width
                    viewModel.screenHeight  = geometry.size.height
                    if databasePointer == nil {databasePointer = CA_DatabaseHelper.getDatabasePointer(databaseName: "CSIDAssistPlusFoodDatabase.db")
                    }
                }
                .onDisappear(perform: {
                    viewModel.resetCalendar()
                })
                .overlay {
                    viewModel.inProgress ?
                    ZStack {
                        Color.black.opacity(0.01)
                            .ignoresSafeArea(.all)
                        CA_ProgressBarView()
                        
                    }
                    : nil
                }
                .overlay (alignment: .topTrailing) {
                    (viewModel.activeSearch ?
                     HStack {
                        Text(viewModel.sortingLabel)
                            .font(.system(size: 14))
                            .foregroundStyle(.caTurqBlue)
                        CA_SortDropDownList(viewModel: viewModel)
                    }.offset(x: -(viewModel.screenWidth * 0.05089059), y: viewModel.screenHeight * 0.16) : nil)
                }
            }
        }).ignoresSafeArea(.keyboard)
    }
}

#Preview {
    HomeScreen()
}
