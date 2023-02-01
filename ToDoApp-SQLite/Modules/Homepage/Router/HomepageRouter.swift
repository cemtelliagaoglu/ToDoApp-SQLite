//
//  HomepageRouter.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import Foundation

class HomepageRouter: HomepagePresenterToRouter{
    
    static func createModule(ref: HomepageVC) {
        let presenter = HomepagePresenter()
        // View
        ref.homepagePresenterObject = presenter
        // Presenter
        ref.homepagePresenterObject?.homepageInteractor = HomepageInteractor()
        ref.homepagePresenterObject?.homepageView = ref
        // Interactor
        ref.homepagePresenterObject?.homepageInteractor?.homepagePresenter = presenter
    }
}
