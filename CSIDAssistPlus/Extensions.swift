//
//  Extensions.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 7/27/24.
//

import Foundation


extension String {
    func dataFormater() -> String {
        guard self != "N/A" else {
            let formattedValue = "N/A"
            return formattedValue
        }
        
        guard let floatValue = Float(self) else { return "N/A" }
        
        let formattedValue = String(format: "%.1f",floatValue)
        
        return formattedValue
    }
}
