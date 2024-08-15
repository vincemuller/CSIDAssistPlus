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
                        CA_SearchBarView(viewModel: viewModel, screenWidth: geometry.size.width, screenHeight: geometry.size.height)
                            .padding(.top, 5)
                            .padding(.bottom, 10)
                        CA_TopDashboardView(activeSearch: $viewModel.activeSearch, expandState: $viewModel.expandSearch, characterView: $viewModel.characterView, helpfulTip: $viewModel.helpfulTip, screenWidth: geometry.size.width, screenHeight: geometry.size.height)
                            .padding(.bottom, viewModel.activeSearch ? 15 : 10)
                        viewModel.expandSearch ? nil : CA_CalendarDashboardView(dashboardWeek: $viewModel.dashboardWeek, selectedDay: $viewModel.selectedDay)
                            .padding(.bottom, 20)
                        viewModel.expandSearch ? nil : HStack (spacing: 15) {
                            CA_HipsterEncouragementView(screenWidth: geometry.size.width, screenHeight: geometry.size.height)
                            CA_DailyNutsView(dailyNuts: viewModel.dailyNuts, screenWidth: geometry.size.width, screenHeight: geometry.size.height)
                        }
                        CA_SearchResultsView(viewModel: viewModel, screenWidth: geometry.size.width, screenHeight: geometry.size.height)
                            .padding(.top, 15)
                    }
                    NavigationLink(destination: CA_AddNewMealScreen()) {
                        viewModel.expandSearch ? nil :
                        CA_AddButtonView(viewModel: viewModel)
                    }.offset(y: 350)
                }
                .onAppear {
                    if databasePointer == nil {databasePointer = CA_DatabaseHelper.getDatabasePointer(databaseName: "CSIDAssistPlusFoodDatabase.db")
                    }
                    print(CFGetRetainCount(viewModel))
                }
                .onDisappear(perform: {
                    viewModel.resetCalendar()
                })
                .overlay {
                    viewModel.getSearchProgress() ?
                    ZStack {
                        Color.black.opacity(0.01)
                            .ignoresSafeArea(.all)
                        CA_ProgressBarView(screenWidth: geometry.size.width, screenHeight: geometry.size.height)
                        
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
                    }.offset(x: -(geometry.size.width * 0.05089059), y: geometry.size.height * 0.16) : nil)
                }
                .sheet(isPresented: $viewModel.foodDetalsPresenting, onDismiss: {
                    viewModel.foodDetalsPresenting = false
                }) {
                    CA_AddNewMealScreen()
                }
            }
        }).ignoresSafeArea(.keyboard)
    }
}

#Preview {
    HomeScreen()
}
