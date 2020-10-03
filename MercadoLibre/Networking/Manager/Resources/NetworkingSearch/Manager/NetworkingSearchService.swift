//
//  NetworkingSearchService.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 4/10/20.
//

import Foundation

class NetworkingSearchService<Router: NetworkingRouterProtocol>: NetworkingBaseRouterProtocol, NetworkingSearchServiceProtocol where Router.EndPoint == NetworkingSearchAPI{
    var router: Router
    
    init(_ router: Router) {
        self.router = router
    }
    
    func search(_ query: String, completion: @escaping NetworkingRouterCompletion) {
        router.request(.searchWithQuery(query: query)) { completion($0, $1, $2) }
    }
}
