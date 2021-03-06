//
//  SearchModel.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 6/10/20.
//

import Foundation
import SwiftUI

/**
    This is your Search Model documentation.
*/
struct SearchModel: Identifiable, Hashable {
    var id: String
    var title: String
    var thumbnail: String
    var price: Int
    var currencyId: String
}
