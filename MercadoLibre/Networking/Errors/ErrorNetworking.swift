//
//  ErrorNetworking.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 2/10/20.
//

import Foundation

enum ErrorNetworking: Error, LocalizedError {
    case authentication
    case badRequest
    case outDated
    case failed
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .authentication: return "You need to be authenticated first."
        case .badRequest: return "Bad request"
        case .outDated: return "The url you requested is outdated."
        case .failed: return "Network request failed."
        case .noData: return "Response returned with no data to decode."
        case .unableToDecode: return "We could not decode the response."
        }
    }
}
