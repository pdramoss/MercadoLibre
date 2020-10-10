//
//  DetailScreenRouter.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 9/10/20.
//

import UIKit

protocol DetailScreenRouter: class {
    var navigationController: UINavigationController? { get }
}

class DetailScreenRouterImplementation: DetailScreenRouter {
    weak var navigationController: UINavigationController?
}
