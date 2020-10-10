//
//  DetailScreenInteractor.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 9/10/20.
//

import Foundation

protocol DetailScreenInteractor {
    var model: SearchModel? { get }
    var presenter: DetailScreenPresenter? { get set }
    
    func viewDidLoad()
}

class DetailScreenInteractorImplementation: DetailScreenInteractor {
    var model: SearchModel?
    var presenter: DetailScreenPresenter?
    
    func viewDidLoad() {
        model.map { presenter?.interactor(didRetrieveModel: $0) }
    }
}
