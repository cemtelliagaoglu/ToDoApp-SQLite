//
//  CreatePageRouter.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import Foundation

class CreatePageRouter: CreatePagePresenterToRouter{
    
    static func createModule(ref: CreatePageVC) {
        ref.createPagePresenterObject = CreatePagePresenter()
        ref.createPagePresenterObject?.createPageInteractor = CreatePageInteractor()
    }
}
