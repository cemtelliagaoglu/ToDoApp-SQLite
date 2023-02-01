//
//  HomepageInteractor.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import Foundation

class HomepageInteractor: HomepagePresenterToInteractor{
    
    var homepagePresenter: HomepageInteractorToPresenter?
    let db: FMDatabase?
    
    init(){
        let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: destinationPath).appendingPathComponent("to-do.sqlite")
        db = FMDatabase(path: databaseURL.path)
    }
    
    
    func loadList() {
        // load list
        var list = [ToDoModel]()
        db?.open()
        do{
            let result = try db!.executeQuery("SELECT * FROM item", values: nil)
            while result.next(){
                let id = Int(result.string(forColumn: "id"))!
                let name = result.string(forColumn: "name")!
                let item = ToDoModel(id: id, name: name)
                list.append(item)
            }
            homepagePresenter?.sendDataToPresenter(list: list)
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func search(_ text: String) {
        // search method
        var list = [ToDoModel]()
                
        db?.open()
        if text != ""{
            do{
                let rs = try db!.executeQuery("SELECT * FROM item WHERE name like ?", values: ["%\(text)%"])
                
                while rs.next() {
                    let id = Int(rs.string(forColumn: "id"))!
                    let name = rs.string(forColumn: "name")!
                    
                    let item = ToDoModel(id: id, name: name)
                    list.append(item)
                }
                
                homepagePresenter?.sendDataToPresenter(list: list)
            }catch{
                print(error.localizedDescription)
            }
        }else{
            loadList()
        }
        db?.close()
        
    }
    
    func delete(_ item: String) {
        // delete method
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM item WHERE name = ?", values: [item])
            loadList()
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
}
