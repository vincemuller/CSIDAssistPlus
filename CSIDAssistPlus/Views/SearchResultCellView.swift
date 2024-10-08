//
//  SearchResultCellView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/12/24.
//

import SwiftUI

struct CA_SearchResultCellView: View {
    
    @Binding var foodDetailsPresenting: Bool
    @Namespace var namespace
    
    var sortingLabel: String
    var foodItem: newUSDAFoodDetails
    var screenWidth: CGFloat
    var screenHeight: CGFloat
    
    var body: some View {
        let width = screenWidth
        let brand = foodItem.brandName?.brandFormater(brandOwner: foodItem.brandOwner ?? "")
        ZStack (alignment: .center) {
            Color.clear.ignoresSafeArea(.all)
            ZStack (alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.caTurqBlue)
                    .frame(width: width.isZero ? 360 : screenWidth * 0.92366, height: screenHeight * 0.118577)
                HStack (spacing: 0) {
                    ZStack {
                        UnevenRoundedRectangle(topLeadingRadius: 12, bottomLeadingRadius: 12, bottomTrailingRadius: 0, topTrailingRadius: 0, style: .continuous)
                            .fill(.caTurqBlue)
                            .frame(width: screenWidth * 0.20356234, height: screenHeight * 0.1198946)
                        VStack {
                            (sortingLabel.contains("Carbs") ? Text("\(foodItem.carbs)g")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.white) : nil)
                            (sortingLabel.contains("Carbs") ? Text("Total Carbs")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(width: screenWidth * 0.19083969) : nil)
                            (!sortingLabel.contains("Carbs") ? Text("\(foodItem.totalSugars)g")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white) : nil)
                            (!sortingLabel.contains("Carbs") ? Text("Total Sugar")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(width: screenWidth * 0.19083969) : nil)
                            (!sortingLabel.contains("Carbs") ? Rectangle()
                                .fill(.white)
                                .frame(width: screenWidth * 0.1653944, height: 2)
                                .padding(.vertical, 2) : nil)
                            (!sortingLabel.contains("Carbs") ? Text("\(foodItem.totalStarches)g")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white) : nil)
                            (!sortingLabel.contains("Carbs") ? Text("Total Starch")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(width: screenWidth * 0.19083) : nil)
                        }
                    }
                    Text(foodItem.description.capitalized)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.black)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.8)
                        .frame(width: screenWidth * 0.6106, alignment: .leading)
                        .offset(x: 10)
                }
                .frame(width: width.isZero ? 360 : screenWidth * 0.92366, height: screenHeight * 0.118577, alignment: .leading)
                Text(brand ?? "")
                    .font(.system(size: 10))
                    .foregroundStyle(.caLightGray)
                    .lineLimit(1)
                    .frame(width: 240, alignment: .leading)
                    .offset(x: screenWidth * 0.234, y: -(screenHeight * 0.04611))
                Text(foodItem.brandedFoodCategory.capitalized)
                    .font(.system(size: 10))
                    .foregroundStyle(.caPink)
                    .frame(width: screenWidth * 0.6106, alignment: .leading)
                    .offset(x: screenWidth * 0.234, y: (screenHeight * 0.04611))
            }
            .overlay (alignment: .topTrailing) {
                Image(systemName: "star.fill")
                    .foregroundColor(.caYellow)
                    .padding(.all, 10)
            }
        }
        .onTapGesture {
            foodDetailsPresenting = true
        }
    }
}

//#Preview {
//    CA_SearchResultCellView(viewModel: HomeScreenViewModel(), foodItem: newUSDAFoodDetails(searchKeyWords: "", fdicID: 0, brandOwner: "Mars Inc.", brandName: "M&M Mars", brandedFoodCategory: "Confectionary and Sweets", description: "Snickers Crunchers, Chocolate Candy Bar", servingSize: 80, servingSizeUnit: "g", carbs: "25", totalSugars: "12.5", totalStarches: "12.5", wholeFood: "no"))
//}
