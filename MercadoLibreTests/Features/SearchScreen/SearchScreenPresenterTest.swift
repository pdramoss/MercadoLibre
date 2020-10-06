//
//  SearchScreenPresenterTest.swift
//  MercadoLibreTests
//
//  Created by Pedro Ramos on 9/10/20.
//

import XCTest
@testable import MercadoLibre

class SearchScreenPresenterTest: XCTestCase {

    var sut: SearchScreenPresenterImplementation!
    var mockView: MockView!
    
    override func setUp() {
        super.setUp()
        sut = SearchScreenPresenterImplementation()
        mockView = MockView()
        sut.viewController = mockView
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockView = nil
    }
    
    func test_interactorDidRetrieveData_ViewCalled() {
        // When
        sut.interactor(didRetrieveData: Dummydata.shared.searchElement)
        
        // Then
        XCTAssertTrue(mockView.updateListCalled)
    }
    
    func test_interactorDidFailedRetrieveData_ViewCalled() {
        // When
        sut.interactor(didFailRetrieveData: Dummydata.shared.error)
        
        // Then
        XCTAssertTrue(mockView.didFailSearchCalled)
    }
    
    class MockView: SearchScreenPresenterOutput {
        var interactor: SearchScreenInteractor?
        var router: SearchScreenRouter?
        var delegate: SearchScreenViewDelegate?
        var updateListCalled: Bool = false
        var didFailSearchCalled: Bool = false
        
        func updateList(_ list: [SearchModel]) {
            updateListCalled = true
        }
        
        func didFailSearch(_ error: Error) {
            didFailSearchCalled = true
        }
    }
    
    class Dummydata {
        static var shared: Dummydata {
            return Dummydata()
        }
        
        var searchElement: SearchElement {
            return SearchElement(siteId: "siteId",
                                 query: "query",
                                 paging: PagingElement(total: 0,
                                                       primaryResults: 0,
                                                       offset: 0,
                                                       limit: 0),
                                 results: [ResultElement(id: "id1",
                                                         title: "title1",
                                                         price: 1,
                                                         currencyId: "currency1",
                                                         availableQuantity: 1,
                                                         soldQuantity: 1,
                                                         stopTime: Date(),
                                                         permalink: "permalink",
                                                         thumbnail: "thumbnail1",
                                                         acceptsMercadopago: false,
                                                         address: nil,
                                                         categoryId: "categoyId")],
                                 availableFilters: [])
        }
        
        var error: Error {
            ErrorNetworking.failed
        }
    }

}
