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
    @Published var filteredUSDAFoodData: [USDAFoodDetails] = []
    
    func searchFoods() {

        var searchTerms = ""
        var wF = ""
        
        if wholeFoodsFilter {
            wF = "USDAFoodDetails.wholeFood='yes' AND"
        } else if brandedFoodsFilter {
            wF = "USDAFoodDetails.wholeFood='no' AND"
        } else {
            wF = ""
        }
        
        let filter = searchText
        
        filteredUSDAFoodData = []
        
        var searchComponents = filter.lowercased().components(separatedBy: " ")
        searchComponents = searchComponents.filter{$0 != ""}
        
        var count = 0
        while count < searchComponents.count {
            if count==0 {
                searchTerms = "\(wF) USDAFoodDetails.searchKeyWords LIKE '%\(searchComponents[count])%' "
            } else {
                searchTerms = searchTerms + "AND USDAFoodDetails.searchKeyWords LIKE '%\(searchComponents[count])%'"
            }
            count = count + 1
        }
        
        let queryResult = CADatabaseQueryHelper.queryDatabaseGeneralSearch(searchTerms: searchTerms, databasePointer: databasePointer)
        filteredUSDAFoodData = queryResult
        
        guard filteredUSDAFoodData.count != 0 else {
            return
        }
    }
    
}
