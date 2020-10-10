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
    
    func interactor(didRetrieveModel model: SearchModel) {
        viewController?.setupViewController(model)
    }
}
