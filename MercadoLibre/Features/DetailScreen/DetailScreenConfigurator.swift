//
//  DetailScreenConfigurator.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 9/10/20.
//

import Foundation

class DetailScreenConfigurator {
    
    /// Clase encargada de la creacion y configuracion de los componentes del modulo DetailScreen
    /// - Parameters:
    ///   - viewController: DetailScreenView clase encargada de la vista
    ///   - model: SearchModel componente encargado de tener la informacion del producto.
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
