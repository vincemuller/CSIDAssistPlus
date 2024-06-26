//
//  CA_DatabaseQueryHelper.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/15/24.
//

import UIKit
import SQLite3
import Foundation

class CADatabaseQueryHelper {
    
    static func dataFormater(value: String) -> String {
        guard value != "N/A" else {
            let formattedValue = "N/A"
            return formattedValue
        }
        
        guard let floatValue = Float(value) else { return "N/A" }
        
        let formattedValue = String(format: "%.1f",floatValue)
        
        return formattedValue
    }
    
    static func sqlColumnProcessing(queryStatement: UnsafePointer<UInt8>!) -> String {
        if let result = queryStatement {
            return String(cString: result)
        } else {
            return ""
        }
    }
    
    static func queryiCloudFavs(searchTerms: String, databasePointer: OpaquePointer?) -> [USDAFoodDetails] {
        var filteredUSDAFoodData: [USDAFoodDetails] = []
        var queryStatement: OpaquePointer?
        let queryStatementString = """
            SELECT searchKeyWords, fdicID, brandOwner, brandName, brandedFoodCategory, description, servingSize, servingSizeUnit, ingredients, wholeFood FROM USDAFoodDetails
            WHERE \(searchTerms)
            ORDER BY wholeFood DESC, length(description);
            """
        if sqlite3_prepare_v2(
          databasePointer,
          queryStatementString,
          -1,
          &queryStatement,
          nil
        ) == SQLITE_OK {
            var searchKeyWords: String
            var fdicID: Int
            var brandOwner: String
            var brandName: String
            var brandCategory: String
            var descr: String
            var servingSize: Float
            var servingSizeUnit: String
            var ingredients: String
            var wholeFoods: String
            
          while (sqlite3_step(queryStatement) == SQLITE_ROW) {
              
              searchKeyWords    = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 0))
              fdicID            = Int(sqlite3_column_int(queryStatement, 1))
              brandOwner        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 2))
              brandName         = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 3))
              brandCategory     = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 4))
              descr             = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 5))
              servingSize       = Float(sqlite3_column_double(queryStatement, 6))
              servingSizeUnit   = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 7))
              ingredients       = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 8))
              wholeFoods        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 9))
              
              filteredUSDAFoodData.append(contentsOf: [USDAFoodDetails(searchKeyWords: searchKeyWords, fdicID: fdicID, brandOwner: brandOwner, brandName: brandName, brandedFoodCategory: brandCategory, description: descr, servingSize: servingSize, servingSizeUnit: servingSizeUnit, ingredients: ingredients, wholeFood: wholeFoods)])
            }
        } else {
            let errorMessage    = String(cString: sqlite3_errmsg(databasePointer))
        }
        sqlite3_finalize(queryStatement)
        return filteredUSDAFoodData
    }
    
    static func queryDatabaseGeneralSearch(searchTerms: String, databasePointer: OpaquePointer?) -> [USDAFoodDetails] {
        
        var filteredUSDAFoodData: [USDAFoodDetails] = []
        var queryStatement: OpaquePointer?
        let queryStatementString = """
            SELECT searchKeyWords, fdicID, brandOwner, brandName, brandedFoodCategory, description, servingSize, servingSizeUnit, ingredients, wholeFood FROM USDAFoodDetails
            WHERE \(searchTerms)
            ORDER BY wholeFood DESC, length(description)
            LIMIT 500;
            """
        
        if sqlite3_prepare_v2(
          databasePointer,
          queryStatementString,
          -1,
          &queryStatement,
          nil
        ) == SQLITE_OK {
            
            var searchKeyWords: String
            var fdicID: Int
            var brandOwner: String
            var brandName: String
            var brandCategory: String
            var descr: String
            var servingSize: Float
            var servingSizeUnit: String
            var ingredients: String
            var wholeFoods: String
            
          while (sqlite3_step(queryStatement) == SQLITE_ROW) {
              
              searchKeyWords    = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 0))
              fdicID            = Int(sqlite3_column_int(queryStatement, 1))
              brandOwner        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 2))
              brandName         = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 3))
              brandCategory     = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 4))
              descr             = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 5))
              servingSize       = Float(sqlite3_column_double(queryStatement, 6))
              servingSizeUnit   = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 7))
              ingredients       = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 8))
              wholeFoods        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 9))
              
              filteredUSDAFoodData.append(contentsOf: [USDAFoodDetails(searchKeyWords: searchKeyWords, fdicID: fdicID, brandOwner: brandOwner, brandName: brandName, brandedFoodCategory: brandCategory, description: descr, servingSize: servingSize, servingSizeUnit: servingSizeUnit, ingredients: ingredients, wholeFood: wholeFoods)])
            }
        } else {
            let errorMessage    = String(cString: sqlite3_errmsg(databasePointer))
        }
        sqlite3_finalize(queryStatement)
        return filteredUSDAFoodData
    }
    
    
    static func queryDatabaseCategorySearch(categorySearchTerm: String, searchTerm: String, wholeFoodsFilter: String, databasePointer: OpaquePointer?) -> [USDAFoodDetails] {
        
        var filteredUSDAFoodData: [USDAFoodDetails] = []
        var queryStatement: OpaquePointer?
        let queryStatementString = """
            SELECT searchKeyWords, fdicID, brandOwner, brandName, brandedFoodCategory, description, servingSize, servingSizeUnit, ingredients, wholeFood FROM USDAFoodDetails
            WHERE brandedFoodCategory LIKE '\(categorySearchTerm)'
            \(searchTerm)
            \(wholeFoodsFilter)
            ORDER BY wholeFood DESC, length(description)
            LIMIT 500;
            """
        if sqlite3_prepare_v2(
          databasePointer,
          queryStatementString,
          -1,
          &queryStatement,
          nil
        ) == SQLITE_OK {
            var searchKeyWords: String
            var fdicID: Int
            var brandOwner: String
            var brandName: String
            var brandCategory: String
            var descr: String
            var servingSize: Float
            var servingSizeUnit: String
            var ingredients: String
            var wholeFoods: String
            
          while (sqlite3_step(queryStatement) == SQLITE_ROW) {
              
              searchKeyWords    = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 0))
              fdicID            = Int(sqlite3_column_int(queryStatement, 1))
              brandOwner        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 2))
              brandName         = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 3))
              brandCategory     = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 4))
              descr             = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 5))
              servingSize       = Float(sqlite3_column_double(queryStatement, 6))
              servingSizeUnit   = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 7))
              ingredients       = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 8))
              wholeFoods        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 9))
              
              filteredUSDAFoodData.append(contentsOf: [USDAFoodDetails(searchKeyWords: searchKeyWords, fdicID: fdicID, brandOwner: brandOwner, brandName: brandName, brandedFoodCategory: brandCategory, description: descr, servingSize: servingSize, servingSizeUnit: servingSizeUnit, ingredients: ingredients, wholeFood: wholeFoods)])
            }
        } else {
            let errorMessage    = String(cString: sqlite3_errmsg(databasePointer))

        }
        sqlite3_finalize(queryStatement)
        return filteredUSDAFoodData
    }
    
    static func queryDatabaseNutrientData(fdicID: Int, databasePointer: OpaquePointer?) -> USDANutrientData {
        
        var queryStatement:     OpaquePointer?
        var nutrientData:       USDANutrientData?
        var carbs:              String = "N/A"
        var netCarbs:           String = "N/A"
        var totalSugars:        String = "N/A"
        var totalStarches:      String = "N/A"
        var totalSugarAlcohols: String = "N/A"
        var fiber:              String = "N/A"
        var protein:            String = "N/A"
        var totalFat:           String = "N/A"
        var sodium:             String = "N/A"
        
        let queryStatementString = """
            SELECT carbs, totalSugars, totalSugarAlcohols, fiber, protein, totalFat, sodium FROM USDAFoodNutData
            WHERE fdicID=\(fdicID);
            """
        if sqlite3_prepare_v2(
          databasePointer,
          queryStatementString,
          -1,
          &queryStatement,
          nil
        ) == SQLITE_OK {
        if sqlite3_step(queryStatement) == SQLITE_ROW {
            if let queryResultCarbs = sqlite3_column_text(queryStatement, 0) {
                carbs    = String(cString: queryResultCarbs)
            } else {
                carbs    = "N/A"
            }
            if let queryResultTotalSugars = sqlite3_column_text(queryStatement, 1) {
                totalSugars = String(cString: queryResultTotalSugars)
            } else {
                totalSugars = "N/A"
            }
            if let queryResultTotalSugarAlcohols = sqlite3_column_text(queryStatement, 2) {
                totalSugarAlcohols = String(cString: queryResultTotalSugarAlcohols)
            } else {
                totalSugarAlcohols = "N/A"
            }
            if let queryResultFiber = sqlite3_column_text(queryStatement, 3) {
                fiber = String(cString: queryResultFiber)
            } else {
                fiber = "N/A"
            }
            if let queryResultProtein = sqlite3_column_text(queryStatement, 4) {
                protein = String(cString: queryResultProtein)
            } else {
                protein = "N/A"
            }
            if let queryResultTotalFat = sqlite3_column_text(queryStatement, 5) {
                totalFat = String(cString: queryResultTotalFat)
            } else {
                totalFat = "N/A"
            }
            if let queryResultSodium = sqlite3_column_text(queryStatement, 6) {
                sodium = String(cString: queryResultSodium)
            } else {
                sodium = "N/A"
            }
              }
            
          } else {
              let errorMessage    = String(cString: sqlite3_errmsg(databasePointer))
              print("error originating from queryDatabaseNutrientData in CADatabaseQueryHelper \(errorMessage)")

          }
          sqlite3_finalize(queryStatement)
        
        //Calculating net data
        //Net Carbs
        if carbs == "N/A" {
            netCarbs = "N/A"
        } else if fiber == "N/A" {
            netCarbs = String(format: "%.1f",Float(carbs) ?? 0)
        } else if totalSugarAlcohols == "N/A" {
            let nC = (max((Float(carbs)!)-(Float(fiber)!), 0))
            netCarbs = String(format: "%.1f",Float(nC))
        } else {
            let nC = (max((Float(carbs)!)-(Float(fiber)!)-(Float(totalSugarAlcohols)!), 0))
            netCarbs = String(format: "%.1f",Float(nC))
        }
        
        //Total Starches
        if carbs == "N/A" || totalSugars == "N/A" {
            totalStarches   = "N/A"
        } else if fiber == "N/A" {
            let tS   = (max((Float(carbs)!)-(Float(totalSugars)!), 0))
            totalStarches = String(format: "%.1f",Float(tS))
        } else {
            let tS = (max((Float(carbs)!)-(Float(fiber)!)-(Float(totalSugars)!), 0))
            totalStarches = String(format: "%.1f",Float(tS))
        }
        
        carbs       = dataFormater(value: carbs)
        totalSugars = dataFormater(value: totalSugars)
        fiber       = dataFormater(value: fiber)
        totalSugarAlcohols = dataFormater(value: totalSugarAlcohols)
        protein     = dataFormater(value: protein)
        totalFat    = dataFormater(value: totalFat)
        sodium      = dataFormater(value: sodium)
        
        nutrientData = USDANutrientData(carbs: carbs, fiber: fiber, netCarbs: netCarbs, totalSugars: totalSugars, totalStarches: totalStarches, totalSugarAlcohols: totalSugarAlcohols, protein: protein, totalFat: totalFat, sodium: sodium)
        
        return nutrientData!
    }
    
    static func queryDatabaseWholeFoodNutrientData(fdicID: Int, databasePointer: OpaquePointer?) -> WholeFoodNutrientData {
        
        var nutrientData:       WholeFoodNutrientData?
        var queryStatement:     OpaquePointer?
        var carbs:              String = "N/A"
        var totalSugars:        String = "N/A"
        var fructose:           String = "N/A"
        var glucose:            String = "N/A"
        var lactose:            String = "N/A"
        var maltose:            String = "N/A"
        var sucrose:            String = "N/A"
        var starch:             String = "N/A"
        
        let queryStatementString = """
            SELECT carbs, totalSugars, fructose, glucose, lactose, maltose, sucrose, starch FROM USDAFoodNutData
            WHERE fdicID=\(fdicID);
            """
        if sqlite3_prepare_v2(
          databasePointer,
          queryStatementString,
          -1,
          &queryStatement,
          nil
        ) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                if let queryResultCarbs = sqlite3_column_text(queryStatement, 0) {
                    carbs    = String(cString: queryResultCarbs)
                } else {
                    carbs    = "N/A"
                }
                if let queryResultTotalSugars = sqlite3_column_text(queryStatement, 1) {
                    totalSugars = String(cString: queryResultTotalSugars)
                } else {
                    totalSugars = "N/A"
                }
                if let queryResultFructose = sqlite3_column_text(queryStatement, 2) {
                    fructose = String(cString: queryResultFructose)
                } else {
                    fructose = "N/A"
                }
                if let queryResultGlucose = sqlite3_column_text(queryStatement, 3) {
                    glucose = String(cString: queryResultGlucose)
                } else {
                    glucose = "N/A"
                }
                if let queryResultLactose = sqlite3_column_text(queryStatement, 4) {
                    lactose = String(cString: queryResultLactose)
                } else {
                    lactose = "N/A"
                }
                if let queryResultMaltose = sqlite3_column_text(queryStatement, 5) {
                    maltose = String(cString: queryResultMaltose)
                } else {
                    maltose = "N/A"
                }
                if let queryResultSucrose = sqlite3_column_text(queryStatement, 6) {
                    sucrose = String(cString: queryResultSucrose)
                } else {
                    sucrose = "N/A"
                }
                if let queryResultStarch = sqlite3_column_text(queryStatement, 7) {
                    starch = String(cString: queryResultStarch)
                } else {
                    starch = "N/A"
                }
            }
          } else {
              let errorMessage    = String(cString: sqlite3_errmsg(databasePointer))
              print("Error message from CADatabaseQueryHelper Whole Food func: \(errorMessage)")

          }
          sqlite3_finalize(queryStatement)
        
        carbs       = dataFormater(value: carbs)
        totalSugars = dataFormater(value: totalSugars)
        starch      = dataFormater(value: starch)
        sucrose     = dataFormater(value: sucrose)
        fructose    = dataFormater(value: fructose)
        glucose     = dataFormater(value: glucose)
        lactose     = dataFormater(value: lactose)
        maltose     = dataFormater(value: maltose)
        
        
        nutrientData = WholeFoodNutrientData(carbs: carbs, totalSugars: totalSugars, totalStarches: starch, sucrose: sucrose, fructose: fructose, glucose: glucose, lactose: lactose, maltose: maltose)
        
        return nutrientData!
    }
    
    static func queryDatabaseFavorites(searchTerms: String, databasePointer: OpaquePointer?) -> [USDAFoodDetails] {
        
        var filteredUSDAFoodData: [USDAFoodDetails] = []
        var queryStatement: OpaquePointer?
        let queryStatementString = """
            SELECT searchKeyWords, fdicID, brandOwner, brandName, brandedFoodCategory, description, servingSize, servingSizeUnit, ingredients, wholeFood FROM USDAFoodDetails
            WHERE \(searchTerms)
            ORDER BY wholeFood DESC, length(description)
            """
        if sqlite3_prepare_v2(
          databasePointer,
          queryStatementString,
          -1,
          &queryStatement,
          nil
        ) == SQLITE_OK {
            var searchKeyWords: String
            var fdicID: Int
            var brandOwner: String
            var brandName: String
            var brandCategory: String
            var descr: String
            var servingSize: Float
            var servingSizeUnit: String
            var ingredients: String
            var wholeFoods: String
            
          while (sqlite3_step(queryStatement) == SQLITE_ROW) {
              
              searchKeyWords    = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 0))
              fdicID            = Int(sqlite3_column_int(queryStatement, 1))
              brandOwner        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 2))
              brandName         = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 3))
              brandCategory     = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 4))
              descr             = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 5))
              servingSize       = Float(sqlite3_column_double(queryStatement, 6))
              servingSizeUnit   = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 7))
              ingredients       = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 8))
              wholeFoods        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 9))
              
              filteredUSDAFoodData.append(contentsOf: [USDAFoodDetails(searchKeyWords: searchKeyWords, fdicID: fdicID, brandOwner: brandOwner, brandName: brandName, brandedFoodCategory: brandCategory, description: descr, servingSize: servingSize, servingSizeUnit: servingSizeUnit, ingredients: ingredients, wholeFood: wholeFoods)])
            }
        } else {
            let errorMessage    = String(cString: sqlite3_errmsg(databasePointer))
            print(errorMessage)
        }
        sqlite3_finalize(queryStatement)
        return filteredUSDAFoodData
    }

}
