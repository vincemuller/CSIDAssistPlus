//
//  CASearchBar2View.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/10/24.
//

import SwiftUI

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
                    .stroke(viewModel.expandSearch ? Color.caTurqBlue : Color.gray.opacity(0.2))
                    .frame(width: viewModel.expandSearch ? expandedWidth - 10 : compWidth, height: height)
                    .overlay(alignment: .center) {
                        (!viewModel.expandSearch ? Text("SEARCH").foregroundStyle(Color.black).opacity(0.3) : nil)
                    }
                    .overlay(alignment: .leading) {
                        (viewModel.expandSearch && viewModel.searchText.isEmpty ? CA_CarouselView() : nil)
                            .padding(.horizontal, 30)
                    }
                HStack (spacing: 0) {
                    TextField("", text: $viewModel.searchText)
                        .foregroundColor(Color.black)
                        .padding()
                        .frame(width: viewModel.expandSearch ? expandedWidth - 40 : compWidth, height: height)
                        .focused($isFocused)
                        .onTapGesture {
                            withAnimation(.bouncy) {
                                viewModel.expandSearch = true
                                viewModel.characterView = 20
                                isFocused = true
                            }
                        }
                        .onSubmit {
                            withAnimation {
                                viewModel.searchFoods()
                                viewModel.activeSearch = true
                            }
                        }
                    (!viewModel.searchText.isEmpty ?
                     Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.caLightOrange)
                        .padding(.horizontal, -15)
                        .onTapGesture {
                            withAnimation(.bouncy) {
                                viewModel.searchText = ""
                            }
                        } : nil)
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
