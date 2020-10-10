//
//  DetailScreenConfigurator.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 9/10/20.
//

import Foundation

class DetailScreenConfigurator {
    static func configureModule(_ viewController: DetailScreenViewController, model: SearchModel) {
        let router = DetailScreenRouterImplementation()
        let interactor = DetailScreenInteractorImplementation()
        let presenter = DetailScreenPresenterImplementation()
        
        viewController.router = router
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        interactor.model = model
        
        presenter.viewController = viewController
        
        router.navigationController = viewController.navigationController
    }
}
