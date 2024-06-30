//
//  CA_TopDashboardView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/15/24.
//

import SwiftUI

struct CA_TopDashboardView: View {
    
    @StateObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        let height = (viewModel.activeSearch ? 1.5 : viewModel.screenHeight * 0.197)
        let width = viewModel.screenWidth * 0.89
        let cornerRadius: CGFloat = (viewModel.activeSearch ? 0 : 30)
        
        ZStack (alignment: .top) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.caTurqBlue)
                .frame(width: width, height: height)
                .overlay(alignment: .center) {
                    Image("csidAssistLogoWhite")
                        .resizable()
                        .frame(width: 350, height: 350)
                        .rotationEffect(.degrees(17))
                        .offset(x: 50)
                        .mask {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: width, height: height)
                        }
                        .opacity(0.2)
                }
            Image("hipsterAnimal")
                .resizable()
                .frame(width: 150, height: viewModel.activeSearch ? 0 : 150)
                .offset(x: width * 0.23, y: viewModel.characterView)
                .mask {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: width, height: height)
                }
        }
    }
}


#Preview {
    CA_TopDashboardView(viewModel: HomeScreenViewModel())
}
