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
    @State var searchFunc: () -> ()
    var compWidth: CGFloat = 100
    var expandedWidth: CGFloat = 320
    var height: CGFloat = 40
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: expandedWidth / 2, height: expandedWidth / 2))
                    .fill(viewModel.activeSearch ? Color.white : Color.white.opacity(0.3))
                    .frame(width: viewModel.activeSearch ? expandedWidth - 20 : compWidth, height: height)
                    .overlay(alignment: .center) {
                        (!viewModel.activeSearch ? Text("SEARCH").opacity(0.3) : nil)
                    }
                    .overlay(alignment: .leading) {
                        (viewModel.activeSearch && viewModel.searchText.isEmpty ? CA_CarouselView() : nil)
                            .padding(.horizontal, 15)
                    }
                TextField("", text: $viewModel.searchText)
                    .foregroundColor(Color.black)
                    .padding()
                    .frame(width: viewModel.activeSearch ? expandedWidth - 20 : compWidth, height: height)
                    .focused($isFocused)
                    .onTapGesture {
                        withAnimation(.bouncy) {
                            viewModel.activeSearch = true
                            viewModel.characterView = 20
                            isFocused = true
                        }
                    }
            }
            (viewModel.activeSearch ? Text("cancel").foregroundStyle(Color.caBrightOrange)
                .onTapGesture {
                    withAnimation(.bouncy) {
                        viewModel.activeSearch = false
                        viewModel.searchText = ""
                        isFocused = false
                        viewModel.characterView = 150
                    }
                }
             : nil)
        }
    }
}

#Preview {
    CA_SearchBarView(viewModel: HomeScreenViewModel()) {
        print("Search func executed!")
    }
}
