//
//  EndPointType.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 2/10/20.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var data: Data? { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get}
}

extension EndPointType {
    private var environmentBaseURl: String {
        Environment.baseURL
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURl) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    func encode<T>(_ value: T) -> Data? where T : Encodable {
        do {
            return try JSONEncoder().encode(value)
        } catch {
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        nil
    }
}
