//
//  NetworkingSearchAPI.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 4/10/20.
//

import Foundation

enum NetworkingSearchAPI {
    case searchWithQuery(query: String)
}

extension NetworkingSearchAPI: EndPointType {
    var path: String {
        let subPath = "/search"
        switch self {
        case .searchWithQuery:
            return subPath
        }
    }
    
    var data: Data? {
        return nil
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        switch self {
        case .searchWithQuery(let query):
            return ["q" : query]
        }
    }
}
