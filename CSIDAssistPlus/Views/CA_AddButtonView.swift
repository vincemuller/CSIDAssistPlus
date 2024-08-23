//
//  CA_AddButtonView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/15/24.
//


import SwiftUI

struct CA_AddButtonView: View {
    
    var body: some View {
        ZStack {
            Image(systemName: "fork.knife.circle")
                .font(.system(size: 50, weight: .semibold))
                .foregroundStyle(.caTurqBlue)
        }
    }
}

#Preview {
    CA_AddButtonView()
}
