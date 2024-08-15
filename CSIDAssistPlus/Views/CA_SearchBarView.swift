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
    
    var screenWidth: CGFloat
    var screenHeight: CGFloat
    
    var body: some View {
        let compWidth = screenWidth * 0.25
        let expandedWidth = screenWidth * 0.90
        let height = screenHeight * 0.05
        
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(viewModel.expandSearch ? Color.white : Color.clear)
                    .frame(width: viewModel.expandSearch ? expandedWidth - 10 : compWidth, height: height)
                RoundedRectangle(cornerRadius: 30)
                    .stroke(viewModel.expandSearch ? Color.caTurqBlue : Color.gray.opacity(0.2))
                    .frame(width: viewModel.expandSearch ? expandedWidth - 10 : compWidth, height: height)
                    .overlay(alignment: .leading) {
                        HStack (spacing: 0) {
                            (viewModel.expandSearch ?
                             Image(systemName: "arrow.left")
                                .font(.system(size: 20, weight: .semibold))
                                .offset(x: 7)
                                .foregroundStyle(Color.caTurqBlue)
                                .onTapGesture {
                                    withAnimation(.bouncy) {
                                        viewModel.searchCompress()
                                        isFocused = false
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
                ZStack {
                    TextField("", text: $viewModel.searchText)
                        .foregroundColor(Color.black)
                        .frame(width: viewModel.expandSearch ? expandedWidth - 75 : compWidth, height: height, alignment: .leading)
                        .focused($isFocused)
                        .padding(.horizontal, 5)
                        .onSubmit {
                            viewModel.searchFoods()
                            print(CFGetRetainCount(viewModel))
                        }
                    viewModel.expandSearch ? nil :
                    Button {
                        withAnimation(.bouncy) {
                            viewModel.searchExpand()
                            isFocused = true
                        }
                    } label: {
                        Text("SEARCH")
                            .foregroundStyle(Color.black).opacity(0.3)
                            .frame(width: compWidth, height: height)
                    }

                }
            }
            
        }
        (viewModel.expandSearch ? CA_ScopeButtonView(viewModel: viewModel) : nil)
    }
}

#Preview {
    CA_SearchBarView(viewModel: HomeScreenViewModel(), screenWidth: 393, screenHeight: 759)
}
