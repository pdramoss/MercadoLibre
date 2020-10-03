//
//  NetworkingSearchAdapter.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 4/10/20.
//

import Foundation

class NetworkingSearchAdapter: DefaultNetworkManager, NetworkingSearchAdapterProtocol {
    var service: NetworkingSearchServiceProtocol
    
    init(_ service: NetworkingSearchServiceProtocol = NetworkingSearchService(NetworkingRouter<NetworkingSearchAPI>())) {
        self.service = service
    }
    
    func search(_ query: String, completion: @escaping (Result<SearchElement, Error>) -> Void) {
        service.search(query) { [weak self] (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let self = self, let response = response else {
                completion(.failure(ErrorNetworking.failed))
                return
            }
            switch self.handleNetwork(response) {
            case .success:
                do {
                    let content: SearchElement = try self.load(data: data)
                    completion(.success(content))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
