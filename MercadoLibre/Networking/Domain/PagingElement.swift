//
//  PagingElement.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 3/10/20.
//

import Foundation

/**
    This is your PagingElement documentation.
*/
struct PagingElement: Codable {
    var total: Int
    var primaryResults: Int
    var offset: Int
    var limit: Int
}
