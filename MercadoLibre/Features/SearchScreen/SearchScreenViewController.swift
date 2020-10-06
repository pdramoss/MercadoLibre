//
//  SearchViewController.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 5/10/20.
//

import Combine
import SwiftUI
import UIKit

protocol SearchScreenPresenterOutput: class {
    var interactor: SearchScreenInteractor? { get set }
    var router: SearchScreenRouter? { get set }
    var delegate: SearchScreenViewDelegate? { get set }
    func updateList(_ list: [SearchModel])
    func didFailSearch(_ error: Error)
}

class SearchScreenViewController: UIViewController {
    var interactor: SearchScreenInteractor?
    var router: SearchScreenRouter?
    var searchView: SearchScreenSwiftUIView?
    var delegate: SearchScreenViewDelegate?
    var searchQuery: String = String() {
        didSet {
            if searchQuery.count >= 3 {
                self.interactor?.didSearchData(for: searchQuery)
            }
        }
    }
    
    private var cancellable: AnyCancellable!
    
    override func loadView() {
        super.loadView()
        searchView.map { setupSearchView($0) }
    }
    
    private func setupSearchView(_ searchView: SearchScreenSwiftUIView) {
        let childView = UIHostingController(rootView: searchView)
        addChild(childView)
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
        childView.view.translatesAutoresizingMaskIntoConstraints = false
        childView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        childView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        childView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        childView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.cancellable = delegate?.$query.sink { query in
            self.searchQuery = query
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewDidAppear(animated)
    }
}

extension SearchScreenViewController: SearchScreenPresenterOutput {
    func updateList(_ list: [SearchModel]) {
        DispatchQueue.main.async {
            self.delegate?.list = list
        }
    }
    
    func didFailSearch(_ error: Error) {
        self.delegate?.error = error
    }
}
