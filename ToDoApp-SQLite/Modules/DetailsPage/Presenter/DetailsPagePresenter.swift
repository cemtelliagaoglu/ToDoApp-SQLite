//
//  DetailsPagePresenter.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import Foundation

class DetailsPagePresenter: DetailsPageViewToPresenter{
    
    // Property
    var detailsPageInteractor: DetailsPagePresenterToInteractor?
    // Method
    func updateItem(_ item: ToDoModel, withNewName name: String) {
        detailsPageInteractor?.updateItem(item, withNewName: name)
    }
}
