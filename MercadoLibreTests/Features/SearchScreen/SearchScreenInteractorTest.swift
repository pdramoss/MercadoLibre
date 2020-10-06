//
//  SearchScreenInteractorTest.swift
//  MercadoLibreTests
//
//  Created by Pedro Ramos on 9/10/20.
//

import XCTest
@testable import MercadoLibre

class SearchScreenInteractorTest: XCTestCase {

    var sut: SearchScreenInteractorImplementation!
    var mockPresenter: MockPresenter!
    
    override func setUp() {
        super.setUp()
        sut = SearchScreenInteractorImplementation()
        mockPresenter = MockPresenter()
        sut.presenter = mockPresenter
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockPresenter = nil
    }
    
    func test_success_presenterCalles() {
        // Given
        sut.networking = MockNetworkingSearch.shared.getSuccessCall()
        
        // When
        sut.didSearchData(for: "Quino")
        
        // Then
        XCTAssertTrue(mockPresenter.interactorRetrieveCalled)
    }
    
    func test_failed_presenterCalles() {
        // Given
        sut.networking = MockNetworkingSearch.shared.getFailedCall()
        
        // When
        sut.didSearchData(for: "Quino")
        
        // Then
        XCTAssertTrue(mockPresenter.interactorFailedCalled)
    }
    
    class MockPresenter: SearchScreenPresenter {
        var viewController: SearchScreenPresenterOutput?
        var interactorRetrieveCalled: Bool = false
        var interactorFailedCalled: Bool = false
        
        func interactor(didRetrieveData data: SearchElement) {
            interactorRetrieveCalled = true
        }
        
        func interactor(didFailRetrieveData error: Error) {
            interactorFailedCalled = true
        }
    }
}
