//
//  NetworkingSearchTest.swift
//  MercadoLibreTests
//
//  Created by Pedro Ramos on 4/10/20.
//

import XCTest
@testable import MercadoLibre

class NetworkingSearchTest: XCTestCase {
    var sut: NetworkingSearchAdapter!
    
    override func setUp() {
        sut = NetworkingSearchAdapter()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_ServiceSuccess_DataExist() {
        // Given
        let exp = expectation(description: "Post request completed")
        var postResult: Result<SearchElement, Error>!
        self.setupNetworking(file: .searchQuery, code: 200)
        
        // When
        sut.search("Quino") { (result) in
            postResult = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        let actualInfo = try? postResult.get()
        
        // Then
        XCTAssertNotNil(actualInfo)
    }
    
    func test_ServiceSuccess_DataNotExist_ErrorNotData() {
        // Given
        let exp = expectation(description: "Post request completed")
        var postResult: Result<SearchElement, Error>!
        self.setupNetworking(file: .none, code: 200)
        
        // When
        sut.search("Quino") { (result) in
            postResult = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
        // Then
        var actualError: Error?
        XCTAssertThrowsError(try postResult.get()) { (error) in
            actualError = error
        }
        XCTAssertEqual(actualError?.localizedDescription, ErrorNetworking.noData.localizedDescription)
    }
    
    func test_ServiceSuccess_DataNotExist_ErrorUnableToDecode() {
        
        // Given
        let exp = expectation(description: "Post request completed")
        var postResult: Result<SearchElement, Error>!
        self.setupNetworking(file: .decodeFail, code: 200)
        
        // When
        sut.search("Quino") { (result) in
            postResult = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
        // Then
        var actualError: Error?
        XCTAssertThrowsError(try postResult.get()) { (error) in
            actualError = error
        }
        XCTAssertEqual(actualError?.localizedDescription, ErrorNetworking.unableToDecode.localizedDescription)
    }
    
    func test_ServiceFailed_DataNotExist_ErrorAuthentication() {
        // Given
        let exp = expectation(description: "Post request completed")
        var postResult: Result<SearchElement, Error>!
        self.setupNetworking(file: .none, code: 400)
        
        // When
        sut.search("Quino") { (result) in
            postResult = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
        // Then
        var actualError: Error?
        XCTAssertThrowsError(try postResult.get()) { (error) in
            actualError = error
        }
        XCTAssertEqual(actualError?.localizedDescription, ErrorNetworking.authentication.localizedDescription)
    }
    
    func test_ServiceFailed_DataNotExist_ErrorBadRequest() {
        // Given
        let exp = expectation(description: "Post request completed")
        var postResult: Result<SearchElement, Error>!
        self.setupNetworking(file: .none, code: 500)
        
        // When
        sut.search("Quino") { (result) in
            postResult = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
        // Then
        var actualError: Error?
        XCTAssertThrowsError(try postResult.get()) { (error) in
            actualError = error
        }
        XCTAssertEqual(actualError?.localizedDescription, ErrorNetworking.badRequest.localizedDescription)
    }
    
    func test_ServiceFailed_DataNotExist_ErrorOutDated() {
        // Given
        let exp = expectation(description: "Post request completed")
        var postResult: Result<SearchElement, Error>!
        self.setupNetworking(file: .none, code: 600)
        
        // When
        sut.search("Quino") { (result) in
            postResult = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
        // Then
        var actualError: Error?
        XCTAssertThrowsError(try postResult.get()) { (error) in
            actualError = error
        }
        XCTAssertEqual(actualError?.localizedDescription, ErrorNetworking.outDated.localizedDescription)
    }
    
    private func setupNetworking(file: JsonFiles? = nil, code: Int, error: Error? = nil) {
        let router = MockRouter.shared.createMockSession(fromJsonFile: file, andStatusCode: code, andError: error, as: NetworkingSearchAPI.self)
        let service = NetworkingSearchService(router)
        sut = NetworkingSearchAdapter(service)
    }
}
