//
//  CA_DatabaseHelper.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/15/24.
//

import Foundation
import SQLite3

class CA_DatabaseHelper {
    static func getDatabasePointer(databaseName: String) -> OpaquePointer? {
        var databasePointer: OpaquePointer?
        
        let bundlePath = Bundle.main.resourceURL?.appendingPathComponent(databaseName).path
        
        if sqlite3_open(bundlePath, &databasePointer) ==  SQLITE_OK {
            print("Successfully Opened Database")
        } else {
            print("Could Not Open Database!")
        }
        return databasePointer
    }
    
}
