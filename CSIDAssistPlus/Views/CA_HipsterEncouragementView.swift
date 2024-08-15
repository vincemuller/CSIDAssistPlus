//
//  CA_HipsterEncouragementView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 8/11/24.
//

import SwiftUI

struct CA_HipsterEncouragementView: View {
    @StateObject var viewModel: HomeScreenViewModel
    var screenWidth: CGFloat
    var screenHeight: CGFloat
    
    var body: some View {
        (viewModel.expandSearch ? nil :
            HStack (spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.caTurqBlue, lineWidth: 3)
                    .frame(width: screenWidth/2.4, height: screenHeight * 0.197)
                    .overlay(alignment: .center) {
                        Image("hipsterAnimal")
                            .resizable()
                            .frame(width: screenWidth * 0.33, height: viewModel.expandSearch ? 0 : screenWidth * 0.33)
                            .offset(y: 25)
                            .mask {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: screenWidth/2.4, height: screenHeight * 0.197)
                            }
                    }
                CA_TypeWriterView()
                    .offset(y: -(screenHeight * 0.05928))
            }
        })
    }
}

#Preview {
    CA_HipsterEncouragementView(viewModel: HomeScreenViewModel(), screenWidth: 393, screenHeight: 759)
}
