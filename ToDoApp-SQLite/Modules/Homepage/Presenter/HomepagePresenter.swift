//
//  HomepagePresenter.swift
//  ToDoApp-SQLite
//
//  Created by admin on 1.02.2023.
//

import Foundation
//MARK: - ViewToPresenter Methods
class HomepagePresenter: HomepageViewToPresenter{
    //MARK: - Protocol Properties
    var homepageInteractor: HomepagePresenterToInteractor?
    var homepageView: HomepagePresenterToView?
    
    //MARK: - Protocol Methods
    func loadList() {
        homepageInteractor?.loadList()
    }
    
    func search(_ text: String) {
        homepageInteractor?.search(text)
    }
    
    func delete(_ item: String) {
        homepageInteractor?.delete(item)
    }
}


//MARK: - PresenterToView Methods
extension HomepagePresenter: HomepageInteractorToPresenter{
    func sendDataToPresenter(list: [ToDoModel]) {
        homepageView?.sendDataToView(list: list)
    }
}

