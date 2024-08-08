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
    
    var body: some View {
        let width = viewModel.screenWidth
        let brand = foodItem.brandName?.brandFormater(brandOwner: foodItem.brandOwner ?? "")

        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(.caTurqBlue)
                .frame(width: width.isZero ? 360 : width - 30, height: 90)
            HStack (spacing: 0) {
                ZStack {
                    UnevenRoundedRectangle(topLeadingRadius: 12, bottomLeadingRadius: 12, bottomTrailingRadius: 0, topTrailingRadius: 0, style: .continuous)
                        .fill(.caTurqBlue)
                        .frame(width: 80, height: 91)
                    (viewModel.sortFilter.contains("carbs") ? nil :
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
                    })
                }
                Text(foodItem.description.capitalized)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black)
                    .lineLimit(3)
                    .minimumScaleFactor(0.7)
                    .frame(width: 220, alignment: .leading)
                    .offset(x: 10)
                Button {
                    print("Add item to food log")
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 30))
                        .foregroundColor(.green)
                        .padding(.horizontal, 15)
                }
            }
            .frame(width: width.isZero ? 360 : width - 30, height: 90, alignment: .leading)
            Text(brand ?? "")
                .font(.system(size: 10))
                .foregroundStyle(.caLightGray)
                .offset(x: 92, y: -35)
            Text(foodItem.brandedFoodCategory.capitalized)
                .font(.system(size: 10))
                .foregroundStyle(.caPink)
                .offset(x: 92, y: 35)
        }
    }
}

#Preview {
    CA_SearchResultCellView(viewModel: HomeScreenViewModel(), foodItem: newUSDAFoodDetails(searchKeyWords: "", fdicID: 0, brandOwner: "Mars Inc.", brandName: "M&M Mars", brandedFoodCategory: "Confectionary and Sweets", description: "Snickers Crunchers, Chocolate Candy Bar", servingSize: 80, servingSizeUnit: "g", carbs: "25", totalSugars: "12.5", totalStarches: "12.5", wholeFood: "no"))
}


//Text("\(foodItem.carbs)g")
//    .font(.system(size: 18, weight: .bold))
//    .foregroundStyle(.white)
//Text("Total Carbs")
//    .font(.system(size: 12, weight: .bold))
//    .foregroundStyle(.white)
//    .frame(width: 75)
