//
//  SearchResultCellView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/12/24.
//

import SwiftUI

struct CA_SearchResultCellView: View {
    @StateObject var viewModel: HomeScreenViewModel
    var foodItem: newUSDAFoodDetails
//    var fdicID: Int             = 0
//    var brandOwner: String      = ""
//    var brandName: String       = ""
//    var category: String        = ""
//    var description: String     = ""
//    var servingSize: String     = ""
//    var servingSizeUnit: String = ""
//    var carbs: String           = ""
//    var totalSugars: String     = ""
//    var totalStarchs: String    = ""
    
    var body: some View {
        let width = viewModel.screenWidth
        let brand = foodItem.brandName?.brandFormater(brandOwner: foodItem.brandOwner ?? "")

        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(.caTurqBlue)
                .frame(width: width.isZero ? 360 : width - 30, height: 110)
            HStack (spacing: 0) {
                ZStack {
                    UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 15, bottomTrailingRadius: 0, topTrailingRadius: 0, style: .continuous)
                        .fill(.caTurqBlue)
                    VStack {
                        Text("\(foodItem.totalSugars)g")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                        Text("Total Sugar")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 75)
                        Rectangle()
                            .fill(.white)
                            .frame(width: 65, height: 2)
                            .padding(.vertical, 2)
                        Text("\(foodItem.totalStarches)g")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                        Text("Total Starch")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 75)
                    }
                }
                .frame(width: 80, height: 111)
                Text(foodItem.description)
                    .foregroundStyle(.black)
                    .lineLimit(3)
                    .minimumScaleFactor(0.7)
                    .frame(width: 220, alignment: .leading)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    CA_SearchResultCellView(viewModel: HomeScreenViewModel(), foodItem: newUSDAFoodDetails(searchKeyWords: "", fdicID: 0, brandOwner: "Mars Inc.", brandName: "M&M Mars", brandedFoodCategory: "Confectionary and Sweets", description: "Snickers Crunchers Chocolate bar", servingSize: 80, servingSizeUnit: "g", carbs: "25", totalSugars: "12.5", totalStarches: "12.5", wholeFood: "no"))
}
