//
//  CA_HipsterEncouragementView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 8/11/24.
//

import SwiftUI

struct CA_HipsterEncouragementView: View {
    @StateObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        (viewModel.expandSearch ? nil :
            HStack (spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.caTurqBlue, lineWidth: 3)
                    .frame(width: viewModel.screenWidth/2.4, height: viewModel.screenHeight * 0.197)
                    .overlay(alignment: .center) {
                        Image("hipsterAnimal")
                            .resizable()
                            .frame(width: viewModel.screenWidth * 0.33, height: viewModel.activeSearch ? 0 : viewModel.screenWidth * 0.33)
                            .offset(y: 25)
                            .mask {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: viewModel.screenWidth/2.4, height: viewModel.screenHeight * 0.197)
                            }
                    }
                CA_TypeWriterView()
                    .offset(y: -(viewModel.screenHeight * 0.05928))
            }
        })
    }
}

#Preview {
    CA_HipsterEncouragementView(viewModel: HomeScreenViewModel())
}
