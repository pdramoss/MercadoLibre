//
//  SearchRouter.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 5/10/20.
//

import UIKit

protocol SearchScreenRouter: class {
    var navigationController: UINavigationController? { get }
    
    func routeToDetail(_ model: SearchModel)
}

class SearchScreenRouterImplementation: SearchScreenRouter {
    weak var navigationController: UINavigationController?
    
    func routeToDetail(_ model: SearchModel) {
        let storyboard = UIStoryboard(name: "DetailScreen", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: "DetailScreenViewController") as? DetailScreenViewController
        viewController.map { DetailScreenConfigurator.configureModule($0, model: model) }
        viewController.map { navigationController?.pushViewController($0, animated: true) }
    }
}
