//
//  NetworkingSearchProtocols.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 4/10/20.
//

import Foundation

protocol NetworkingSearchAdapterProtocol {
    var service: NetworkingSearchServiceProtocol { get set }
    
    func search(_ query: String, completion: @escaping (Result<SearchElement, Error>) -> Void)
}

protocol NetworkingSearchServiceProtocol {
    func search(_ query: String, completion: @escaping NetworkingRouterCompletion)
}
