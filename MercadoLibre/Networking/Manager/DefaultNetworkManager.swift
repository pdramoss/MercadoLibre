//
//  DefaultNetworkManager.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 2/10/20.
//

import Foundation

protocol DefaultNetworkManagerProtocol {
    func handleNetwork(_ response: HTTPURLResponse) -> Result<Bool, Error>
}

class DefaultNetworkManager: DefaultNetworkManagerProtocol {
    
    private func getDateFormatter() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }
    
    func load<T: Decodable> (data: Data?, as type: T.Type = T.self) throws -> T {
        guard let data = data else { throw ErrorNetworking.noData }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(getDateFormatter())
            return try decoder.decode(T.self, from: data)
        } catch {
            Logger.error("ERROR PARSE DATA: \(error)")
            throw ErrorNetworking.unableToDecode
        }
    }
    
    func handleNetwork(_ response: HTTPURLResponse) -> Result<Bool, Error> {
        switch response.statusCode {
        case 200...299: return .success(true)
        case 400...499: return .failure(ErrorNetworking.authentication)
        case 500...599: return .failure(ErrorNetworking.badRequest)
        case 600: return .failure(ErrorNetworking.outDated)
        default: return .failure(ErrorNetworking.failed)
        }
    }
}
