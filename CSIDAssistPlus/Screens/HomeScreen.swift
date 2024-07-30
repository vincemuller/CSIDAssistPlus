//
//  HomeScreen.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/3/24.
//

import SwiftUI

struct HomeScreen: View {   
    @StateObject private var viewModel = HomeScreenViewModel()
    @State private var delay = false
    
    var body: some View {
        
        GeometryReader(content: { geometry in
            NavigationStack {
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
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.caTurqBlue, lineWidth: 3)
                                    .frame(width: viewModel.screenWidth/2.4, height: viewModel.screenHeight * 0.197)
                                    .overlay(alignment: .center) {
                                        Image("hipsterAnimal")
                                            .resizable()
                                            .frame(width: 130, height: viewModel.activeSearch ? 0 : 130)
                                            .offset(y: 25)
                                            .mask {
                                                RoundedRectangle(cornerRadius: 30)
                                                    .frame(width: viewModel.screenWidth/2.4, height: viewModel.screenHeight * 0.197)
                                            }
                                    }
                                (delay ? CA_TypeWriterView() : nil)
                                    .offset(y: -45)
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.caTurqBlue.opacity(0.2))
                                    .frame(width: viewModel.screenWidth/2.4, height: viewModel.screenHeight * 0.197)
                                Text("Daily Stats")
                                    .foregroundStyle(Color.caDarkBlue)
                                    .font(.system(size: 16, weight: .semibold))
                                    .offset(y: 55)
                            }
                        })
                        CA_SearchResultsView(viewModel: viewModel)
                    }
                    NavigationLink(destination: CA_AddNewMealScreen()) {
                        CA_AddButtonView(viewModel: viewModel)
                    }.offset(y: 350)
                }
                .onAppear {
                    viewModel.screenWidth = geometry.size.width
                    viewModel.screenHeight = geometry.size.height
                    if databasePointer == nil {databasePointer = CA_DatabaseHelper.getDatabasePointer(databaseName: "CSIDAssistFoodDatabase2.db")
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        delay = true
                    })
                }
                .onDisappear(perform: {
                    delay = false
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
            }
        }).ignoresSafeArea(.keyboard)
    }
}

#Preview {
    HomeScreen()
}

//NavigationStack {
//    NavigationLink {
//    }
//}
