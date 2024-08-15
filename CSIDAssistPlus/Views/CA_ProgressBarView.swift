//
//  CA_ProgressBarView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/29/24.
//

import SwiftUI

struct CA_ProgressBarView: View {
    var screenWidth: CGFloat
    var screenHeight: CGFloat
    
    var body: some View {
        Image("CSIDLogoTurqBlue")
            .resizable()
            .frame(width: screenWidth * 0.50890585, height: screenWidth * 0.50890585)
            .opacity(0.3)
    }
}

#Preview {
    CA_ProgressBarView(screenWidth: 393, screenHeight: 759)
}
