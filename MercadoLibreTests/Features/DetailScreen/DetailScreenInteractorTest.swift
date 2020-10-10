//
//  DetailScreenInteractorTest.swift
//  MercadoLibreTests
//
//  Created by Pedro Ramos on 10/10/20.
//

import XCTest
@testable import MercadoLibre

class DetailScreenInteractorTest: XCTestCase {

    private var sut: DetailScreenInteractorImplementation!
    private var mockPresenter: MockPresenter!
    
    override func setUp() {
        super.setUp()
        sut = DetailScreenInteractorImplementation()
        mockPresenter = MockPresenter()
        sut.presenter = mockPresenter
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockPresenter = nil
    }
    
    func test_modelExist_presenterCalled() {
        // Given
        sut.model = DummyData.shared.model
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockPresenter.interactorDidRetrieveModelCalled)
    }
    
    func test_modelNotExist_presenterCalled() {
        // Given
        sut.model = nil
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertFalse(mockPresenter.interactorDidRetrieveModelCalled)
    }
    
    class MockPresenter: DetailScreenPresenter {
        var viewController: DetailScreenPresenterOutput?
        var interactorDidRetrieveModelCalled: Bool = false
        
        func interactor(didRetrieveModel model: SearchModel) {
            interactorDidRetrieveModelCalled = true
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
