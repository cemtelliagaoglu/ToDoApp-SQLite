//
//  CreatePageInteractor.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import Foundation

class CreatePageInteractor: CreatePagePresenterToInteractor{
    
    var db: FMDatabase?
    
    init(){
        let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: destinationPath).appendingPathComponent("to-do.sqlite")
        db = FMDatabase(path: databaseURL.path)
    }
    
    func createToDo(_ itemName: String) {
        
        db?.open()
        do{
            try db?.executeUpdate("INSERT INTO item (name) VALUES (?)", values: [itemName])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
}
