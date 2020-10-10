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
    
    
    /// Funcion encargada de cambiar el objeto Element a Model para poder mostrarlo en la vista
    /// - Parameter data: SearchElement componente con los componentes de la busqueda
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
    
    
    /// Funcion encargada de informarle a la vista que se presento un error
    /// - Parameter error: Error que se presenta al fallar el servicio
    func interactor(didFailRetrieveData error: Error) {
        viewController?.didFailSearch(error)
    }
}
