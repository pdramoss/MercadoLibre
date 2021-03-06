//
//  SearchInteractor.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 5/10/20.
//

import Foundation

protocol SearchScreenInteractor: class {
    var presenter: SearchScreenPresenter? { get set }
    
    func didSearchData(for query: String)
}

class SearchScreenInteractorImplementation: SearchScreenInteractor {
    var presenter: SearchScreenPresenter?
    var networking: NetworkingSearchAdapterProtocol?
    
    init(_ networking: NetworkingSearchAdapterProtocol = NetworkingSearchAdapter()) {
        self.networking = networking
    }
    
    
    /// Funcion encargada de realizar el llamado al API para poder obtener la lista de los productos de busqueda
    /// - Parameter query: Texto encargado de la busqueda
    func didSearchData(for query: String) {
        self.networking?.search(query, completion: { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.presenter?.interactor(didRetrieveData: data)
            case .failure(let error):
                self?.presenter?.interactor(didFailRetrieveData: error)
            }
        })
    }
}
