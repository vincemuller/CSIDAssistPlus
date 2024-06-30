//
//  CASearchBar2View.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/10/24.
//

import SwiftUI
import Foundation

struct CA_SearchBarView: View {
    @StateObject var viewModel: HomeScreenViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        let compWidth = viewModel.screenWidth * 0.25
        let expandedWidth = viewModel.screenWidth * 0.90
        let height = viewModel.screenHeight * 0.05

        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(viewModel.expandSearch ? Color.white : Color.clear)
                    .frame(width: viewModel.expandSearch ? expandedWidth - 10 : compWidth, height: height)
                RoundedRectangle(cornerRadius: 30)
                    .stroke(viewModel.expandSearch ? Color.caTurqBlue : Color.gray.opacity(0.2))
                    .frame(width: viewModel.expandSearch ? expandedWidth - 10 : compWidth, height: height)
                    .overlay(alignment: .center) {
                        (!viewModel.expandSearch ? Text("SEARCH").foregroundStyle(Color.black).opacity(0.3) : nil)
                    }
                    .overlay(alignment: .leading) {
                        HStack (spacing: 0) {
                            (viewModel.expandSearch ?
                             Image(systemName: "arrow.left")
                                .font(.system(size: 20, weight: .semibold))
                                .offset(x: 7)
                                .foregroundStyle(Color.caTurqBlue)
                                .onTapGesture {
                                    withAnimation(.bouncy) {
                                        viewModel.expandSearch = false
                                        isFocused = false
                                        viewModel.characterView = 150
                                        viewModel.activeSearch = false
                                        viewModel.allFoodsFilter = true
                                        viewModel.brandedFoodsFilter = false
                                        viewModel.wholeFoodsFilter = false
                                        viewModel.searchText = ""
                                    }
                                } : nil)
                            (viewModel.expandSearch && viewModel.searchText.isEmpty ? CA_CarouselView().offset(x: 10) : nil)
                        }
                    }
                    .overlay(alignment: .trailing) {
                        (!viewModel.searchText.isEmpty ?
                         Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.caRed)
                            .offset(x: -7)
                            .onTapGesture {
                                withAnimation(.bouncy) {
                                    viewModel.searchText = ""
                                    isFocused = true
                                }
                            } : nil)
                    }
                
                TextField("", text: $viewModel.searchText)
                    .foregroundColor(Color.black)
                    .frame(width: viewModel.expandSearch ? expandedWidth - 75 : compWidth, height: height, alignment: .leading)
                    .focused($isFocused)
                    .padding(.horizontal, 5)
                    .onTapGesture {
                        withAnimation(.bouncy) {
                            viewModel.expandSearch = true
                            viewModel.characterView = 20
                            isFocused = true
                        }
                    }
                    .onSubmit {
                        withAnimation(.linear.speed(2.5)) {
                            viewModel.activeSearch = true
                            viewModel.searchFoods()
                        }
                    }
            }
            
        }
        (viewModel.expandSearch ? CA_ScopeButtonView(viewModel: viewModel) : nil)
    }
}

//viewModel.expandSearch = false
//isFocused = false
//viewModel.characterView = 150
//viewModel.activeSearch = false
//viewModel.allFoodsFilter = true
//viewModel.brandedFoodsFilter = false
//viewModel.wholeFoodsFilter = false

#Preview {
    CA_SearchBarView(viewModel: HomeScreenViewModel())
}
