//
//  HomeScreen.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/3/24.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel = HomeScreenViewModel()
    @State private var isAddActive: Bool = false
    
    var body: some View {
        GeometryReader(content: { geometry in
            
            let width = geometry.size.width
            let height = geometry.size.height
            
            ZStack {
                LinearGradient(colors: [Color.white, Color.caLightBlue.opacity(0.7)], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea(.all)
                VStack (alignment: .center, spacing: 25) {
                    CA_SearchBarView(viewModel: viewModel, searchFunc: {
                        print("Search Func Executed!")
                    }, compWidth: width * 0.25, expandedWidth: width * 0.75, height: height * 0.05)
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: height * 0.197, height: height * 0.197))
                            .fill(Color.white.opacity(0.6))
                            .frame(width: width * 0.89, height: height * 0.197)
                        Image("hipsterAnimal")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .offset(x: width * 0.23, y: viewModel.characterView)
                            .mask {
                                RoundedRectangle(cornerSize: CGSize(width: height * 0.197, height: height * 0.197))
                                    .frame(width: width * 0.89, height: height * 0.197)
                            }
                    }
                    
                    Spacer()
                }
            }
            .overlay(alignment: .bottom) {
                ZStack {
                    Circle()
                        .fill(isAddActive ? Color.caBrightOrange : Color.green).opacity(0.8)
                        .frame(width: isAddActive ? 35 : 50, height: isAddActive ? 35 : 50)
                    Image(systemName: "plus")
                        .font(.system(size: isAddActive ? 20 : 30, weight: .semibold))
                        .foregroundStyle(Color.white)
                        .rotationEffect(.degrees(isAddActive ? 45 : 0), anchor: .center)
                }
                .onTapGesture {
                    withAnimation(.interactiveSpring) {
                        isAddActive.toggle()
                        print(geometry.size.width)
                    }
                }
            }
        }).ignoresSafeArea(.keyboard)
    }
}

#Preview {
    HomeScreen()
}
