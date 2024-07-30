//
//  HomeScreenViewModel.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/9/24.
//

import Foundation
//
@MainActor final class HomeScreenViewModel: ObservableObject {
    @Published var expandSearch: Bool = false
    @Published var activeSearch: Bool = false
    @Published var inProgress: Bool = false
    @Published var characterView: CGFloat = 150
    @Published var searchText: String = ""
    @Published var wholeFoodsFilter: Bool = false
    @Published var allFoodsFilter: Bool = true
    @Published var brandedFoodsFilter: Bool = false
    @Published var isAddActive: Bool = false
    @Published var screenWidth: CGFloat = 0
    @Published var screenHeight: CGFloat = 0
    @Published var filteredUSDAFoodData: [USDAFoodDetails] = []
    @Published var savedLists: [String] = ["Safe Foods", "Unsafe Foods", "Favorite Foods"]
    @Published var calendarRange: [Int] = [1,5]
    @Published var dashboardWeek = Date.now
    
    func searchFoods() {
        inProgress.toggle()
        
        var searchTerms = ""
        var wF = ""
        let filter = searchText
        filteredUSDAFoodData = []
        
        let searchComponents = filter.lowercased().components(separatedBy: " ").filter{$0 != ""}
        
        if wholeFoodsFilter {
            wF = "USDAFoodDetails.wholeFood='yes' AND"
        } else if brandedFoodsFilter {
            wF = "USDAFoodDetails.wholeFood='no' AND"
        } else {
            wF = ""
        }
        
        var count = 0
        while count < searchComponents.count {
            if count==0 {
                searchTerms = "\(wF) USDAFoodDetails.searchKeyWords LIKE '%\(searchComponents[count])%' "
            } else {
                searchTerms = searchTerms + "AND USDAFoodDetails.searchKeyWords LIKE '%\(searchComponents[count])%'"
            }
            count = count + 1
        }
        
        let serialQueue = DispatchQueue(label: "search.serial.queue")
        let sT = searchTerms
        
        serialQueue.async( execute: {
            
            let queryResult = CADatabaseQueryHelper.queryDatabaseGeneralSearch(searchTerms: sT, databasePointer: databasePointer)

            DispatchQueue.main.async {
                self.filteredUSDAFoodData = queryResult
                self.inProgress.toggle()
            }
            
            guard queryResult.count != 0 else {
                return
            }
        })
    }
}

