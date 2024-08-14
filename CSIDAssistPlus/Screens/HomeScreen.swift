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
                            .padding(.bottom, viewModel.getActiveSearchState() ? 15 : 10)
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
                        viewModel.getExpandState() ? nil :
                        CA_AddButtonView(viewModel: viewModel)
                    }.offset(y: 350)
                }
                .onAppear {
                    viewModel.screenWidth   = geometry.size.width
                    viewModel.screenHeight  = geometry.size.height
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
                        CA_ProgressBarView()
                        
                    }
                    : nil
                }
                .overlay (alignment: .topTrailing) {
                    (viewModel.getActiveSearchState() ?
                     HStack {
                        Text(viewModel.sortingLabel)
                            .font(.system(size: 14))
                            .foregroundStyle(.caTurqBlue)
                        CA_SortDropDownList(viewModel: viewModel)
                    }.offset(x: -(viewModel.screenWidth * 0.05089059), y: viewModel.screenHeight * 0.16) : nil)
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
