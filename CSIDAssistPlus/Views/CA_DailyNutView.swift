//
//  CA_DailyNutView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 8/11/24.
//

import SwiftUI

struct CA_DailyNutIndividualView: View {
    var label: String
    var nutData: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.caLightTurqBlue)
            VStack (spacing: 7) {
                Text(nutData)
                    .foregroundStyle(.caDarkBlue)
                    .font(.system(size: 17, weight: .semibold))
                Text(label)
                    .foregroundStyle(.caDarkBlue)
                    .font(.system(size: 10))
            }
        }.frame(width: 80, height: 70)
    }
}

#Preview {
    CA_DailyNutIndividualView(label: "Total Starches", nutData: "7.5g")
}
