//
//  HomeScreenViewModel.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/9/24.
//

import Foundation

@MainActor final class HomeScreenViewModel: ObservableObject {
    @Published var expandSearch: Bool = false
    @Published var activeSearch: Bool = false
    @Published var inProgress: Bool = false
    @Published var characterView: CGFloat = 150
    @Published var searchText: String = ""
    @Published var sortingLabel: String = "Relevance"
    @Published var sortFilter: String = "wholeFood DESC, length(description)"
    @Published var wholeFoodsFilter: Bool = false
    @Published var allFoodsFilter: Bool = true
    @Published var brandedFoodsFilter: Bool = false
    @Published var isAddActive: Bool = false
    @Published var screenWidth: CGFloat = 0
    @Published var screenHeight: CGFloat = 0
    @Published var filteredUSDAFoodData: [newUSDAFoodDetails] = []
    @Published var savedLists: [String] = ["Safe Foods", "Unsafe Foods", "Favorite Foods"]
    @Published var calendarRange: [Int] = [1,5]
    @Published var dashboardWeek = Date.now
    @Published var selectedDay = Date.now
    @Published var helpfulTip: String = ""
    @Published var dailyNuts: [DailyNutData] = [DailyNutData(label: "Total Carbs", nutData: "25.0g"),DailyNutData(label: "Net Carbs", nutData: "20.0g"),DailyNutData(label: "Total Sugars", nutData: "12.5g"), DailyNutData(label: "Total Starches", nutData: "7.5g")]
    @Published var mealBuilder: [USDANutrientData] = [USDANutrientData(carbs: "5", fiber: "5", netCarbs: "5", totalSugars: "5", totalStarches: "5", totalSugarAlcohols: "5", protein: "5", totalFat: "5", sodium: "5")]
    
    func generateTip() {
        helpfulTip = CA_HelpfulTipsModel().getTip(index: Int.random(in: 0...5))
    }
    
    func resetCalendar() {
        dashboardWeek = Date.now
        selectedDay = Date.now
    }
    
    func searchFoods() {
        
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
}

