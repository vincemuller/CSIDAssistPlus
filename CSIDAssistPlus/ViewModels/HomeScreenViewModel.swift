//
//  HomeScreenViewModel.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/9/24.
//

import Foundation

class HomeScreenViewModel: ObservableObject {
    @Published var expandSearch: Bool = false
    @Published var activeSearch: Bool = false
    @Published var characterView: CGFloat = 150
    @Published var searchText: String = ""
    @Published var wholeFoodsFilter: Bool = false
    @Published var allFoodsFilter: Bool = true
    @Published var brandedFoodsFilter: Bool = false
    @Published var isAddActive: Bool = false
    @Published var screenWidth: CGFloat = 0
    @Published var screenHeight: CGFloat = 0
    
    func searchFoods() {
        print("Search Function Executed!")
    }
}
