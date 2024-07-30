//
//  CAPlaceholderTextView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/9/24.
//

import SwiftUI

struct CA_CarouselView: View {
    @State private var offset = 18.5
    @State private var index = 0
    @State private var id: Bool = false
    
    private let timer = Timer.publish(every: 3.5, on: .main, in: .common).autoconnect()
    var hints: [String] = ["foods", "brands", "UPCs"]
    
    var body: some View {
        
        HStack (spacing: 0) {
            Text("Search ")
                .foregroundStyle(Color.black)
            Text(hints[index]).transition(textTransition)
                .foregroundStyle(Color.black)
                .id(id)
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.bouncy) {
                if index < 2 {
                    index += 1
                } else {
                    index = 0
                }
                id.toggle()
            }
        })
        .opacity(0.5)
    }
}

#Preview {
    CA_CarouselView()
}

private var textTransition: AnyTransition {
    .asymmetric(
        insertion: .move(edge: .bottom).combined(with: .opacity),
        removal: .move(edge: .top).combined(with: .opacity)
    )
}
