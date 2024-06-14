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
                    (viewModel.activeSearch ? CA_TopDashboardView(viewModel: viewModel, height: 1.5, width: viewModel.screenWidth) : CA_TopDashboardView(viewModel: viewModel, height: viewModel.screenHeight * 0.197, width: viewModel.screenWidth, cornerRadius: 30))
                        .padding(.bottom, 10)
                    ScrollView {
                        (viewModel.activeSearch ? ForEach((1...10), id: \.self) {_ in
                            SearchResultCellView(viewModel: viewModel)
                        } : nil)
                    }

                    (viewModel.activeSearch ? nil : Spacer())
                }
            }
            .overlay (alignment: .bottom) {
                (!viewModel.activeSearch ? ZStack {
                    Circle()
                        .fill(viewModel.isAddActive ? Color.caBrightOrange : Color.green).opacity(0.8)
                        .frame(width: viewModel.isAddActive ? 35 : 50, height: viewModel.isAddActive ? 35 : 50)
                    Image(systemName: "plus")
                        .font(.system(size: viewModel.isAddActive ? 20 : 30, weight: .semibold))
                        .foregroundStyle(Color.white)
                        .rotationEffect(.degrees(viewModel.isAddActive ? 45 : 0), anchor: .center)
                }
                .onTapGesture {
                    withAnimation(.interactiveSpring) {
                        viewModel.isAddActive.toggle()
                        print(geometry.size.width)
                    }
                } : nil)
            }.onAppear {
                viewModel.screenWidth = geometry.size.width
                viewModel.screenHeight = geometry.size.height
            }
        }).ignoresSafeArea(.keyboard)
    }
}

#Preview {
    HomeScreen()
}

struct CA_TopDashboardView: View {
    @StateObject var viewModel: HomeScreenViewModel
    var height: CGFloat = 1.5
    var width: CGFloat = 40
    var cornerRadius: CGFloat = 0
    
    var body: some View {
        ZStack (alignment: .top) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.caTurqBlue)
                .frame(width: width * 0.89, height: height)
            Image("hipsterAnimal")
                .resizable()
                .frame(width: 150, height: viewModel.activeSearch ? 0 : 150)
                .offset(x: width * 0.23, y: viewModel.characterView)
                .mask {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: width * 0.89, height: height)
                }
        }
    }
}
