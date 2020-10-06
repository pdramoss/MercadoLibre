//
//  MockNetworkingSearch.swift
//  MercadoLibreTests
//
//  Created by Pedro Ramos on 9/10/20.
//

import XCTest
@testable import MercadoLibre

class MockNetworkingSearch {

    static var shared: MockNetworkingSearch {
        return MockNetworkingSearch()
    }

    func getSuccessCall() -> NetworkingSearchAdapterProtocol {
        return setupNetworking(file: .searchQuery, code: 200)
    }
    
    func getFailedCall() -> NetworkingSearchAdapterProtocol {
        return setupNetworking(code: 500)
    }
    
    private func setupNetworking(file: JsonFiles? = nil, code: Int) -> NetworkingSearchAdapterProtocol {
        let router = MockRouter.shared.createMockSession(fromJsonFile: file, andStatusCode: code, as: NetworkingSearchAPI.self)
        let service = NetworkingSearchService(router)
        return NetworkingSearchAdapter(service)
    }
}
