//
//  NetworkingRouter.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 2/10/20.
//

import Foundation

public typealias CompletionData = (Data?, HTTPURLResponse?, Error?)
public typealias NetworkingRouterCompletion = (_ data: Data?, _ response: HTTPURLResponse?, _ error: Error?) -> Void

protocol NetworkingRouterProtocol: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkingRouterCompletion)
    func cancel()
}

protocol NetworkingBaseRouterProtocol {
    associatedtype Router: NetworkingRouterProtocol
    var router: Router { get set }
}

class NetworkingRouter<EndPoint: EndPointType>: NetworkingRouterProtocol {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkingRouterCompletion) {
        let session = URLSession.shared
        var urlRequest = URLRequest(
            url: route.baseURL.appendingPathComponent(route.path),
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10.0)
        urlRequest.httpMethod = route.httpMethod.rawValue
        urlRequest.httpBody = route.httpMethod == .get ? nil : route.data
        if route.httpMethod == .get {
            var newURL = URLComponents(string: urlRequest.url?.absoluteString ?? String())
            newURL?.queryItems = route.parameters?.map({ (key: String, value: Any) -> URLQueryItem in
                URLQueryItem(name: key, value: "\(value)")
            })
            urlRequest.url = newURL?.url
        }
        
        NetworkingLogger.log(request: urlRequest)
        self.task = session.dataTask(with: urlRequest, completionHandler: { completion($0, $1 as? HTTPURLResponse, $2) })
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
}
