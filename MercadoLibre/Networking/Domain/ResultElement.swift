//
//  ResultElement.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 3/10/20.
//

import Foundation

/**
    This is your ResultElement documentation.
*/
struct ResultElement: Codable {
    var id: String
    var title: String
    var price: Int
    var currencyId: String
    var availableQuantity: Int
    var soldQuantity: Int
    var stopTime: Date
    var permalink: String
    var thumbnail: String
    var acceptsMercadopago: Bool
    var address: AddressElement?
    var categoryId: String
}
