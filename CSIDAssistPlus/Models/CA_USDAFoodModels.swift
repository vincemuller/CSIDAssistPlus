//
//  CA_USDAFoodModels.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/15/24.
//

import UIKit
import CloudKit


struct USDAFoodDetails: Codable {
    var searchKeyWords:         String
    var fdicID:                 Int
    var brandOwner:             String?
    var brandName:              String?
    var brandedFoodCategory:    String
    var description:            String
    var servingSize:            Float
    var servingSizeUnit:        String
    var ingredients:            String
    var wholeFood:              String
}

struct newUSDAFoodDetails: Codable {
    var searchKeyWords:         String
    var fdicID:                 Int
    var brandOwner:             String?
    var brandName:              String?
    var brandedFoodCategory:    String
    var description:            String
    var servingSize:            Float
    var servingSizeUnit:        String
    var carbs:                  String
    var totalSugars:            String
    var totalStarches:          String
    var wholeFood:              String
}

struct UserFoodItem: Codable {
    var category:       String
    var description:    String
    var portionSize:    String
    var ingredients:    String
    var totalCarbs:     Float
    var totalFiber:     Float
    var totalSugars:    Float
    var addedSugars:    Float
}

struct USDANutrientData: Codable {
    var carbs:              String
    var fiber:              String
    var netCarbs:           String
    var totalSugars:        String
    var totalStarches:      String
    var totalSugarAlcohols: String
    var protein:            String
    var totalFat:           String
    var sodium:             String
}

struct WholeFoodNutrientData: Codable {
    var carbs:              String
    var totalSugars:        String
    var totalStarches:      String
    var sucrose:            String
    var fructose:           String
    var glucose:            String
    var lactose:            String
    var maltose:            String
}

