//
//  CA_WeekDashboardModel.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/16/24.
//

import Foundation

struct CA_HelpfulTipsModel {
    
    //5 total tips at the moment
    private var tips: [String] = [
        "Find foods quickly by searching on their UPC number",
        "Search multiple key words to further refine your results",
        "Trying to find a whole food? Use the Whole Foods filter",
        "Trying to find a specific brand? Use the Branded Foods filter",
        "Don't forget you can sort your results by carbs, total sugars and starches",
        "Search brand names to find a specific food item"
    ]
    
    func getTip(index: Int) -> String {
        return tips[index]
    }
    
}

