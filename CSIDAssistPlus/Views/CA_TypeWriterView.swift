//
//  CA_TypeWriterView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/30/24.
//

import SwiftUI

struct CA_TypeWriterView: View {
    
    @State var text: String = ""
    let finalText: String = "It's been a busy day\nKeep it up!"
    
    var body: some View {
        VStack(spacing: 16.0) {
            Text(finalText)
                .font(.custom(
                    "AmericanTypewriter",
                    fixedSize: 12))
                .frame(width: 140)
                .multilineTextAlignment(.center)
        }
    }
    
}

#Preview {
    CA_TypeWriterView()
}
