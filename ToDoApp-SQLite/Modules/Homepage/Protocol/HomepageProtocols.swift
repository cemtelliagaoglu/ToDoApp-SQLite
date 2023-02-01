//
//  HomepageProtocols.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import Foundation

// Base Protocols
protocol HomepageViewToPresenter{
    
    var homepageInteractor: HomepagePresenterToInteractor? { get set }
    var homepageView: HomepagePresenterToView? { get set }
    
    func loadList()
    func search(_ text: String)
    func delete(_ item: String)
    
}
protocol HomepagePresenterToInteractor{
    
    var homepagePresenter: HomepageInteractorToPresenter? { get set }
    
    func loadList()
    func search(_ text: String)
    func delete(_ item: String)
}

// Transporting Protocols
protocol HomepageInteractorToPresenter{
    
    func sendDataToPresenter(list: [ToDoModel])
}
protocol HomepagePresenterToView{
    func sendDataToView(list: [ToDoModel])
}

// Router Protocol
protocol HomepagePresenterToRouter{
    static func createModule(ref: HomepageVC)
}

