//
//  CreatePagePresenter.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import Foundation

class CreatePagePresenter: CreatePageViewToPresenter{
    
    var createPageInteractor: CreatePagePresenterToInteractor?
    
    func createToDo(_ itemName: String) {
        createPageInteractor?.createToDo(itemName)
    }
}


