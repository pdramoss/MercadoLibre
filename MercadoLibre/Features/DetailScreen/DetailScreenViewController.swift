//
//  DetailScreenViewController.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 9/10/20.
//

import UIKit

protocol DetailScreenPresenterOutput: class {
    var interactor: DetailScreenInteractor? { get set }
    var router: DetailScreenRouter? { get set }
    
    func setupViewController(_ model: SearchModel)
}

class DetailScreenViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var currencyLabel: UILabel!
    
    var interactor: DetailScreenInteractor?
    var router: DetailScreenRouter?
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewDidLoad()
        self.interactor?.viewDidLoad()
    }
    
    
    /// La funcion encargada de configurar y mostrar el valor del precio del producto.
    /// - Parameters:
    ///   - price: Precio del producto
    ///   - currencyCode: Moneda del producto
    private func setupCurrencyLabel(_ price: Int, currencyCode: String) {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "es_CO")
        formatter.numberStyle = .decimal
        let number = formatter.number(from: "\(price)")
        formatter.currencySymbol = currencyCode
        formatter.numberStyle = .currency
        number.map { currencyLabel.text = formatter.string(from: $0) }
    }
}

extension DetailScreenViewController: DetailScreenPresenterOutput {
    
    /// Funcion encargada de actualizar la vista con la informacion del producto
    /// - Parameter model: SearchModel componente encargado de tener la informcion del producto.
    func setupViewController(_ model: SearchModel) {
        let urlImage = UrlImageModel(urlString: model.thumbnail)
        imageView.image = urlImage.image
        imageView.contentMode = .scaleAspectFit
        titleLabel.text = model.title
        
        setupCurrencyLabel(model.price, currencyCode: model.currencyId)
    }
}
