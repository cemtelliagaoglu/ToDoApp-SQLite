//
//  DetailsPageInteractor.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import Foundation

class DetailsPageInteractor: DetailsPagePresenterToInteractor{
    
    let db: FMDatabase?
    
    init(){
        let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: destinationPath).appendingPathComponent("to-do.sqlite")
        db = FMDatabase(path: databaseURL.path)
    }
    
    func updateItem(_ item: ToDoModel, withNewName name: String){
        db?.open()
        do{
            try db?.executeUpdate("UPDATE item SET name = ? WHERE id = ?", values: [name, item.id])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
}
