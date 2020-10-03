//
//  AvailableFilterElement.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 3/10/20.
//

import Foundation

struct AvailableFilterElement: Codable {
    var id: String
    var name: String
    var type: String
    var values: [AvailableFilterValueElement]
}
