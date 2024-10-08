//
//  CA_SortDropDownList.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 8/2/24.
//

import SwiftUI

struct CA_SortDropDownList: View {
    @State var sortingOptions = ["Relevance", "Carbs (Low to High)", "Carbs (High to Low)", "Sugars (Low to High)", "Sugars (High to Low)", "Starches (Low to High)", "Starches (High to Low)"]
    @Binding var sortingLabel: String
    
    var searchFoods: () -> Void
    
    var body: some View {
        Menu {
            ForEach(sortingOptions, id: \.self){ option in
                Button(action: {self.sortingLabel = option; self.searchFoods()}, label: {
                    Text(option)
                        .font(.system(size: 12))
                        .foregroundStyle(.caTurqBlue)
                })
            }
        } label: {
            Image(systemName: "arrow.up.and.down.text.horizontal")
                .foregroundColor(.caTurqBlue)
                .padding(.bottom, 5)
        }
    }
}


//#Preview {
//    CA_SortDropDownList()
//}
