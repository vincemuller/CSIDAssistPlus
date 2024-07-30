//
//  SearchResultCellView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/12/24.
//

import SwiftUI

struct CA_SearchResultCellView: View {
    @StateObject var viewModel: HomeScreenViewModel
    var category: String = ""
    var brandName: String = ""
    var description: String = ""
    var netCarbs: String = ""
    var totalSugar: String = ""
    var totalStarch: String = ""
    
    var body: some View {
        let width = viewModel.screenWidth
        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(.caTurqBlue)
                .frame(width: width.isZero ? 350 : width - 30, height: 100)
            HStack {
                ZStack {
                    Rectangle()
                        .fill(.caTurqBlue)
                    VStack {
                        Text(totalSugar)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                        Text("Total Sugar")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 75)
                        Rectangle()
                            .fill(.white)
                            .frame(width: 55, height: 2)
                            .padding(.vertical, 2)
                        Text(totalStarch)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                        Text("Total Starch")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 75)
                    }
                }
                .frame(width: 75, height: 101)
                .offset(x: -1.5)
                VStack (alignment: .leading) {
                    Text(brandName.capitalized)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.black)
                    Text(description.capitalized)
                        .dynamicTypeSize(.medium)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                        .foregroundStyle(Color.black)
                        .frame(width: 255, alignment: .leading)
                    Spacer()
                    Text(category.capitalized)
                        .font(.system(size: 10))
                        .foregroundStyle(Color.black)
                        .offset(y: -10)
                }
                .frame(width: 250, height: 90, alignment: .topLeading)
                .offset(y: 5)
            }
        }
        
//        ZStack (alignment: .leading) {
//            RoundedRectangle(cornerRadius: 15)
//                .stroke(.caTurqBlue)
//                .frame(width: width.isZero ? 350 : width - 30, height: 100)
//            RoundedRectangle(cornerRadius: 15)
//                .fill(Color.caTurqBlue)
//                .frame(width: 70, height: 100)
//            HStack {
//                ZStack (alignment: .center) {
//                    Rectangle()
//                        .fill(.caTurqBlue)
//                        .frame(width: 75, height: 101)
//                    VStack {
//                        Text(totalSugar)
//                            .font(.system(size: 16, weight: .bold))
//                            .foregroundStyle(.white)
//                        Text("Total Sugar")
//                            .font(.system(size: 10, weight: .bold))
//                            .foregroundStyle(.white)
//                            .frame(width: 75)
//                        Rectangle()
//                            .fill(.white)
//                            .frame(width: 55, height: 2)
//                            .padding(.vertical, 2)
//                        Text(totalStarch)
//                            .font(.system(size: 16, weight: .bold))
//                            .foregroundStyle(.white)
//                        Text("Total Starch")
//                            .font(.system(size: 10, weight: .bold))
//                            .foregroundStyle(.white)
//                            .frame(width: 75)
//                    }
//                }.offset(x: 20)
//                .frame(width: 25, height: 100)
//                Text(brandName.capitalized)
//                    .font(.system(size: 12))
//                    .foregroundStyle(Color.black)
//            }
//        }
    }
}

#Preview {
    CA_SearchResultCellView(viewModel: HomeScreenViewModel(), category: "Chips, Crackers, Nuts, & Snacks", brandName: "Dot's", description: "Homestyle Pretzels", netCarbs: "15.0g", totalSugar: "0.0g", totalStarch: "15.0g")
}

struct CA_ScopeButtonView: View {
    @StateObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        HStack {
            Button(action: {print("Whole Foods")}, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(viewModel.wholeFoodsFilter ? Color.caTurqBlue : Color.clear)
                        .stroke(viewModel.wholeFoodsFilter ? Color.clear : Color.black.opacity(0.3))
                        .frame(width: 110, height: 30)
                    Text("Whole Foods")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(viewModel.wholeFoodsFilter ? Color.white : Color.black.opacity(0.3))
                }.onTapGesture {
                    if viewModel.wholeFoodsFilter == true {
                        return
                    } else {
                        viewModel.wholeFoodsFilter.toggle()
                        viewModel.allFoodsFilter = false
                        viewModel.brandedFoodsFilter = false
                    }
                    
                    if !viewModel.searchText.isEmpty && viewModel.activeSearch {
                        viewModel.searchFoods()
                    }
                }
            })
            Button(action: {print("All Foods")}, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(viewModel.allFoodsFilter ? Color.caTurqBlue : Color.clear)
                        .stroke(viewModel.allFoodsFilter ? Color.clear : Color.black.opacity(0.3))
                        .frame(width: 110, height: 30)
                    Text("All Foods")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(viewModel.allFoodsFilter ? Color.white : Color.black.opacity(0.3))
                }.onTapGesture {
                    if viewModel.allFoodsFilter == true {
                        return
                    } else {
                        viewModel.allFoodsFilter.toggle()
                        viewModel.wholeFoodsFilter = false
                        viewModel.brandedFoodsFilter = false
                    }
                    
                    if !viewModel.searchText.isEmpty && viewModel.activeSearch {
                        viewModel.searchFoods()
                    }
                }
            })
            Button(action: {print("Branded Foods")}, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(viewModel.brandedFoodsFilter ? Color.caTurqBlue : Color.clear)
                        .stroke(viewModel.brandedFoodsFilter ? Color.clear : Color.black.opacity(0.3))
                        .frame(width: 110, height: 30)
                    Text("Branded Foods")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(viewModel.brandedFoodsFilter ? Color.white : Color.black.opacity(0.3))
                }.onTapGesture {
                    if viewModel.brandedFoodsFilter == true {
                        return
                    } else {
                        viewModel.brandedFoodsFilter.toggle()
                        viewModel.wholeFoodsFilter = false
                        viewModel.allFoodsFilter = false
                    }
                    
                    if !viewModel.searchText.isEmpty && viewModel.activeSearch {
                        viewModel.searchFoods()
                    }
                }
            })
        }
    }
}