//
//  CA_ScopeButtonView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 8/8/24.
//

import SwiftUI

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

#Preview {
    CA_ScopeButtonView(viewModel: HomeScreenViewModel())
}
