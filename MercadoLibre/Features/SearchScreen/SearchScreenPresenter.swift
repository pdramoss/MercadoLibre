//
//  SearchPresenter.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 5/10/20.
//

import Foundation

protocol SearchScreenPresenter: class {
    var viewController: SearchScreenPresenterOutput? { get set }
    
    func interactor(didRetrieveData data: SearchElement)
    func interactor(didFailRetrieveData error: Error)
}

class SearchScreenPresenterImplementation: SearchScreenPresenter {
    weak var viewController: SearchScreenPresenterOutput?
    
    func interactor(didRetrieveData data: SearchElement) {
        let list = data.results.map { SearchModel(
            id: $0.id,
            title: $0.title,
            thumbnail: $0.thumbnail,
            price: $0.price,
            currencyId: $0.currencyId)
        }
        viewController?.updateList(list)
    }
    
    func interactor(didFailRetrieveData error: Error) {
        viewController?.didFailSearch(error)
    }
}
