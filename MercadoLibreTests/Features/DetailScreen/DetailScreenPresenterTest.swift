//
//  DetailScreenPresenterTest.swift
//  MercadoLibreTests
//
//  Created by Pedro Ramos on 10/10/20.
//

import XCTest
@testable import MercadoLibre

class DetailScreenPresenterTest: XCTestCase {

    private var sut: DetailScreenPresenterImplementation!
    private var mockView: MockView!
        
    override func setUp() {
        super.setUp()
        sut = DetailScreenPresenterImplementation()
        mockView = MockView()
        sut.viewController = mockView
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockView = nil
    }
    
    func test_ViewCalled() {
        // When
        sut.interactor(didRetrieveModel: DummyData.shared.model)
        
        // Then
        XCTAssertTrue(mockView.setupViewControllerCalled)
    }
    
    class MockView: DetailScreenPresenterOutput {
        var interactor: DetailScreenInteractor?
        var router: DetailScreenRouter?
        var setupViewControllerCalled: Bool = false
        
        func setupViewController(_ model: SearchModel) {
            setupViewControllerCalled = true
        }
    }
    
    class DummyData {
        static var shared: DummyData {
            return DummyData()
        }
        
        var model: SearchModel {
            return SearchModel(id: "id1",
                               title: "title1",
                               thumbnail: "thumbnail1",
                               price: 1,
                               currencyId: "currencyId1")
        }
    }
}
