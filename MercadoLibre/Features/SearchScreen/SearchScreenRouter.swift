//
//  SearchRouter.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 5/10/20.
//

import UIKit

protocol SearchScreenRouter: class {
    var navigationController: UINavigationController? { get }
    
    func routeToDetail()
}

class SearchScreenRouterImplementation: SearchScreenRouter {
    weak var navigationController: UINavigationController?
    
    func routeToDetail() {
        
    }
}
