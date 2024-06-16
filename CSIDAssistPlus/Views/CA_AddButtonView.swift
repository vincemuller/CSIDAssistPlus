//
//  CA_AddButtonView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/15/24.
//

import SwiftUI

struct CA_AddButtonView: View {
    
    @StateObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        
        let active = viewModel.isAddActive
        
        (!viewModel.activeSearch ? ZStack {
            Circle()
                .fill(active ? Color.caBrightOrange : Color.green).opacity(0.8)
                .frame(width: active ? 35 : 50, height: active ? 35 : 50)
            Image(systemName: "plus")
                .font(.system(size: active ? 20 : 30, weight: .semibold))
                .foregroundStyle(Color.white)
                .rotationEffect(.degrees(active ? 45 : 0), anchor: .center)
        }
            .onTapGesture {
                withAnimation(.interactiveSpring) {
                    viewModel.isAddActive.toggle()
                }
            } : nil)
    }
}

#Preview {
    CA_AddButtonView(viewModel: HomeScreenViewModel())
}
