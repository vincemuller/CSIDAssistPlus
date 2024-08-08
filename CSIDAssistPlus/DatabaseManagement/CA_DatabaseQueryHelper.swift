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
            
          while (sqlite3_step(queryStatement) == SQLITE_ROW) {
              
              let searchKeyWords    = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 0))
              let fdicID            = Int(sqlite3_column_int(queryStatement, 1))
              let brandOwner        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 2))
              let brandName         = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 3))
              let brandCategory     = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 4))
              let descr             = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 5))
              let servingSize       = Float(sqlite3_column_double(queryStatement, 6))
              let servingSizeUnit   = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 7))
              let ingredients       = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 8))
              let wholeFoods        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 9))
              
              filteredUSDAFoodData.append(contentsOf: [USDAFoodDetails(searchKeyWords: searchKeyWords, fdicID: fdicID, brandOwner: brandOwner, brandName: brandName, brandedFoodCategory: brandCategory, description: descr, servingSize: servingSize, servingSizeUnit: servingSizeUnit, ingredients: ingredients, wholeFood: wholeFoods)])
            }
        } else {
            let errorMessage    = String(cString: sqlite3_errmsg(databasePointer))
        }
        sqlite3_finalize(queryStatement)
        return filteredUSDAFoodData
    }
    
    static func queryDatabaseNewGeneralSearch(searchTerms: String, databasePointer: OpaquePointer?, sortFilter: String = "wholeFood DESC, length(description)") -> [newUSDAFoodDetails] {
        
        var carbs:          String = "N/A"
        var totalSugars:    String = "N/A"
        var totalStarches:  String = "N/A"
        
        var filteredUSDAFoodData: [newUSDAFoodDetails] = []

        var queryStatement: OpaquePointer?
        let queryStatementString = """
            SELECT searchKeyWords, fdicID, brandOwner, brandName, brandedFoodCategory, description, servingSize, servingSizeUnit, carbs, totalSugars, totalStarches, wholeFood FROM USDAFoodSearchTable
            WHERE \(searchTerms)
            ORDER BY \(sortFilter);
            """
        
        if sqlite3_prepare_v2(
          databasePointer,
          queryStatementString,
          -1,
          &queryStatement,
          nil
        ) == SQLITE_OK {
            
          while (sqlite3_step(queryStatement) == SQLITE_ROW) {
              
              let searchKeyWords    = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 0))
              let fdicID            = Int(sqlite3_column_int(queryStatement, 1))
              let brandOwner        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 2))
              let brandName         = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 3))
              let brandCategory     = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 4))
              let descr             = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 5))
              let servingSize       = Float(sqlite3_column_double(queryStatement, 6))
              let servingSizeUnit   = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 7))
              
              if let queryResultCarbs = sqlite3_column_text(queryStatement, 8) {
                  carbs = String(cString: queryResultCarbs).dataFormater()
              } else {
                  carbs = "N/A"
              }
              
              if let queryResultTotalSugars = sqlite3_column_text(queryStatement, 9) {
                  totalSugars = String(cString: queryResultTotalSugars).dataFormater()
              } else {
                  totalSugars = "N/A"
              }
              
              if let queryResultFiber = sqlite3_column_text(queryStatement, 10) {
                  totalStarches = String(cString: queryResultFiber).dataFormater()
              } else {
                  totalStarches = "N/A"
              }
              
              let wholeFoods = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 11))
              
              filteredUSDAFoodData.append(contentsOf: [newUSDAFoodDetails(searchKeyWords: searchKeyWords, fdicID: fdicID, brandOwner: brandOwner, brandName: brandName, brandedFoodCategory: brandCategory, description: descr, servingSize: servingSize, servingSizeUnit: servingSizeUnit, carbs: carbs, totalSugars: totalSugars, totalStarches: totalStarches, wholeFood: wholeFoods)])
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

          while (sqlite3_step(queryStatement) == SQLITE_ROW) {
              
              let searchKeyWords    = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 0))
              let fdicID            = Int(sqlite3_column_int(queryStatement, 1))
              let brandOwner        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 2))
              let brandName         = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 3))
              let brandCategory     = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 4))
              let descr             = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 5))
              let servingSize       = Float(sqlite3_column_double(queryStatement, 6))
              let servingSizeUnit   = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 7))
              let ingredients       = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 8))
              let wholeFoods        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 9))
              
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
                carbs    = String(cString: queryResultCarbs).dataFormater()
            } else {
                carbs    = "N/A"
            }
            if let queryResultTotalSugars = sqlite3_column_text(queryStatement, 1) {
                totalSugars = String(cString: queryResultTotalSugars).dataFormater()
            } else {
                totalSugars = "N/A"
            }
            if let queryResultTotalSugarAlcohols = sqlite3_column_text(queryStatement, 2) {
                totalSugarAlcohols = String(cString: queryResultTotalSugarAlcohols).dataFormater()
            } else {
                totalSugarAlcohols = "N/A"
            }
            if let queryResultFiber = sqlite3_column_text(queryStatement, 3) {
                fiber = String(cString: queryResultFiber).dataFormater()
            } else {
                fiber = "N/A"
            }
            if let queryResultProtein = sqlite3_column_text(queryStatement, 4) {
                protein = String(cString: queryResultProtein).dataFormater()
            } else {
                protein = "N/A"
            }
            if let queryResultTotalFat = sqlite3_column_text(queryStatement, 5) {
                totalFat = String(cString: queryResultTotalFat).dataFormater()
            } else {
                totalFat = "N/A"
            }
            if let queryResultSodium = sqlite3_column_text(queryStatement, 6) {
                sodium = String(cString: queryResultSodium).dataFormater()
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
                    carbs    = String(cString: queryResultCarbs).dataFormater()
                } else {
                    carbs    = "N/A"
                }
                if let queryResultTotalSugars = sqlite3_column_text(queryStatement, 1) {
                    totalSugars = String(cString: queryResultTotalSugars).dataFormater()
                } else {
                    totalSugars = "N/A"
                }
                if let queryResultFructose = sqlite3_column_text(queryStatement, 2) {
                    fructose = String(cString: queryResultFructose).dataFormater()
                } else {
                    fructose = "N/A"
                }
                if let queryResultGlucose = sqlite3_column_text(queryStatement, 3) {
                    glucose = String(cString: queryResultGlucose).dataFormater()
                } else {
                    glucose = "N/A"
                }
                if let queryResultLactose = sqlite3_column_text(queryStatement, 4) {
                    lactose = String(cString: queryResultLactose).dataFormater()
                } else {
                    lactose = "N/A"
                }
                if let queryResultMaltose = sqlite3_column_text(queryStatement, 5) {
                    maltose = String(cString: queryResultMaltose).dataFormater()
                } else {
                    maltose = "N/A"
                }
                if let queryResultSucrose = sqlite3_column_text(queryStatement, 6) {
                    sucrose = String(cString: queryResultSucrose).dataFormater()
                } else {
                    sucrose = "N/A"
                }
                if let queryResultStarch = sqlite3_column_text(queryStatement, 7) {
                    starch = String(cString: queryResultStarch).dataFormater()
                } else {
                    starch = "N/A"
                }
            }
          } else {
              let errorMessage    = String(cString: sqlite3_errmsg(databasePointer))
              print("Error message from CADatabaseQueryHelper Whole Food func: \(errorMessage)")

          }
          sqlite3_finalize(queryStatement)
        
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
          while (sqlite3_step(queryStatement) == SQLITE_ROW) {
              
              let searchKeyWords    = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 0))
              let fdicID            = Int(sqlite3_column_int(queryStatement, 1))
              let brandOwner        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 2))
              let brandName         = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 3))
              let brandCategory     = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 4))
              let descr             = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 5))
              let servingSize       = Float(sqlite3_column_double(queryStatement, 6))
              let servingSizeUnit   = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 7))
              let ingredients       = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 8))
              let wholeFoods        = sqlColumnProcessing(queryStatement: sqlite3_column_text(queryStatement, 9))
              
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
