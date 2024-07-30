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
        
        (!viewModel.expandSearch ? ZStack {
            Circle()
                .fill(Color.green).opacity(0.8)
                .frame(width: 50, height: 50)
            Image(systemName: "plus")
                .font(.system(size: 30, weight: .semibold))
                .foregroundStyle(Color.white)
        } : nil)
    }
}

#Preview {
    CA_AddButtonView(viewModel: HomeScreenViewModel())
}
