//
//  DetailScreenPresenter.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 9/10/20.
//

import Foundation

protocol DetailScreenPresenter: class {
    var viewController: DetailScreenPresenterOutput? { get set }
    
    func interactor(didRetrieveModel model: SearchModel)
}

class DetailScreenPresenterImplementation: DetailScreenPresenter {
    weak var viewController: DetailScreenPresenterOutput?
    
    /// Esta función se encarga de informarle a la vista que informacion es la encargada de mostrar
    /// - Parameter model: SearchModel componente encargado de tener la informcion del producto.
    func interactor(didRetrieveModel model: SearchModel) {
        viewController?.setupViewController(model)
    }
}
