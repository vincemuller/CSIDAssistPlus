//
//  SearchViewModel.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 8/14/24.
//

import Foundation

@MainActor final class SearchViewModel: ObservableObject {
    @Published private var activeSearch: Bool = false
    @Published private var inProgress: Bool = false
    @Published var searchText: String = ""
    @Published var sortingLabel: String = "Relevance"
    @Published var sortFilter: String = "wholeFood DESC, length(description)"
    @Published var wholeFoodsFilter: Bool = false
    @Published var allFoodsFilter: Bool = true
    @Published var brandedFoodsFilter: Bool = false
    @Published private var filteredUSDAFoodData: [newUSDAFoodDetails] = []
    
    func getFilteredUSDAFoodData() -> [newUSDAFoodDetails] {
        return filteredUSDAFoodData
    }
    
    func getActiveSearchState() -> Bool {
        return activeSearch
    }
    
    func searchFoods() {
        
        activeSearch = true
        inProgress.toggle()
        
        var searchTerms = ""
        var wF = ""
        let filter = searchText
        filteredUSDAFoodData = []
        
        let searchComponents = filter.lowercased().components(separatedBy: " ").filter{$0 != ""}
        
        if wholeFoodsFilter {
            wF = "USDAFoodSearchTable.wholeFood='yes' AND"
        } else if brandedFoodsFilter {
            wF = "USDAFoodSearchTable.wholeFood='no' AND"
        } else {
            wF = ""
        }
        
        var count = 0
        while count < searchComponents.count {
            if count==0 {
                searchTerms = "\(wF) USDAFoodSearchTable.searchKeyWords LIKE '%\(searchComponents[count])%' "
            } else {
                searchTerms = searchTerms + "AND USDAFoodSearchTable.searchKeyWords LIKE '%\(searchComponents[count])%'"
            }
            count = count + 1
        }
        
        let serialQueue = DispatchQueue(label: "search.serial.queue")
        let sT = searchTerms
        
        if sortingLabel == "Relevance" {
            sortFilter = "wholeFood DESC, length(description)"
        } else if sortingLabel == "Sugars (Low to High)" {
            sortFilter = "CAST(totalSugars AS REAL)"
        } else if sortingLabel == "Sugars (High to Low)" {
            sortFilter = "CAST(totalSugars AS REAL)DESC"
        } else if sortingLabel == "Starches (Low to High)" {
            sortFilter = "CAST(totalStarches AS REAL)"
        } else if sortingLabel == "Starches (High to Low)" {
            sortFilter = "CAST(totalStarches AS REAL)DESC"
        } else if sortingLabel == "Carbs (Low to High)" {
            sortFilter = "CAST(carbs AS REAL)"
        } else if sortingLabel == "Carbs (High to Low)" {
            sortFilter = "CAST(carbs AS REAL)DESC"
        } else {
            sortFilter = "wholeFood DESC, length(description)"
        }
        
        let sortFilter = sortFilter
        
        serialQueue.async( execute: {
            
            let queryResult = CADatabaseQueryHelper.queryDatabaseNewGeneralSearch(searchTerms: sT, databasePointer: databasePointer, sortFilter: sortFilter)
            
            DispatchQueue.main.async {
                self.filteredUSDAFoodData = queryResult
                self.inProgress.toggle()
            }
            
        })
    }
    
    func getSearchProgress() -> Bool {
        return inProgress
    }
}
