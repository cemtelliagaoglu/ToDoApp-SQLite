//
//  CreatePageProtocols.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import Foundation

// Base Protocols
protocol CreatePageViewToPresenter{
    
    var createPageInteractor: CreatePagePresenterToInteractor? { get set }
    
    func createToDo(_ itemName: String)
}

protocol CreatePagePresenterToInteractor{
    func createToDo(_ itemName: String)
}

// Router Protocol
protocol CreatePagePresenterToRouter{
    static func createModule(ref: CreatePageVC)
}
