//
//  ViewController.swift
//  Chapter06-SQLlite3-03
//
//  Created by nakrlove on 2022/12/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dbExecute(getDBPath())
    }

    func getDBPath() -> String {
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dbPath = docPathURL.appendingPathComponent("db.sqlite").path
//        let dbPath = "/Users/nakrlove/db.sqlite"
        
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        
        return dbPath
    }

    func dbExecute(_ dbPath: String){
        
        
        
        var db: OpaquePointer? = nil
        var stmt: OpaquePointer? = nil
        
    
        let sql = "CREATE TABLE IF NOT EXISTS squence(num INTEGER)"
        
//        let dbPath = getDBPath()
        
        guard sqlite3_open(dbPath,&db) == SQLITE_OK else {
            print("Database Connect Fail")
            return
        }
//        if sqlite3_open(dbPath,&db) != SQLITE_OK {
//            print("Database Connect Fail")
//            return
//        }
            
        guard sqlite3_prepare(db,sql,-1,&stmt,nil) == SQLITE_OK else {
            print("Prepare Statment Fail")
            sqlite3_finalize(stmt)
            sqlite3_close(db)
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            print("Create Table Fail")
        } else {
            print("Create Table Success")
        }
        sqlite3_finalize(stmt)
        sqlite3_close(db)
       
    }
}

