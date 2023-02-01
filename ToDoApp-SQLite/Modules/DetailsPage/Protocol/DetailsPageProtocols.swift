//
//  DetailsPageProtocols.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import Foundation

// Base Protocols
protocol DetailsPageViewToPresenter{
    
    var detailsPageInteractor: DetailsPagePresenterToInteractor? { get set }
    
    func updateItem(_ item: ToDoModel, withNewName name: String)
}

protocol DetailsPagePresenterToInteractor{
    func updateItem(_ item: ToDoModel, withNewName name: String)
}

// Router Protocol
protocol DetailsPagePresenterToRouter{
    static func createModule(ref: DetailsPageVC)
}
