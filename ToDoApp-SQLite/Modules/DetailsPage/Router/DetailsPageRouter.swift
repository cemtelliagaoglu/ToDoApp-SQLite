//
//  DetailsPageRouter.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import Foundation


class DetailsPageRouter: DetailsPagePresenterToRouter{
    static func createModule(ref: DetailsPageVC) {
        ref.detailsPagePresenterObject = DetailsPagePresenter()
        ref.detailsPagePresenterObject?.detailsPageInteractor = DetailsPageInteractor()
    }
}
