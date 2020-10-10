//
//  SearchConfigurator.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 5/10/20.
//

import Foundation

class SearchScreenConfigurator {
    
    /// Clase encargada de la creacion y configuracion de los componentes del modulo SearchScreen
    /// - Parameter viewController: SearchScreenView clase encargada de la vista
    static func configureModule(_ viewController: SearchScreenViewController) {
        let delegate = SearchScreenViewDelegate()
        let view = SearchScreenSwiftUIView(delegate: delegate)
        let router = SearchScreenRouterImplementation()
        let interactor = SearchScreenInteractorImplementation()
        let presenter = SearchScreenPresenterImplementation()
        
        viewController.searchView = view
        viewController.router = router
        viewController.interactor = interactor
        viewController.delegate = delegate
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.navigationController = viewController.navigationController
    }
}
