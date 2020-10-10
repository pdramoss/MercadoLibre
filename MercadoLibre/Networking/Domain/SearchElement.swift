//
//  SearchElement.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 3/10/20.
//

import Foundation


/**
    This is your SearchElement documentation.
*/
struct SearchElement: Codable {
    var siteId: String
    var query: String
    var paging: PagingElement
    var results: [ResultElement]
    var availableFilters: [AvailableFilterElement]
}
