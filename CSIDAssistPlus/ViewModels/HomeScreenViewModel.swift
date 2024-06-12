//
//  HomeScreenViewModel.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/9/24.
//

import Foundation

class HomeScreenViewModel: ObservableObject {
    @Published var activeSearch: Bool = false
    @Published var characterView: CGFloat = 150
    @Published var searchText: String = ""
}
