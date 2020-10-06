//
//  CLImage.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 8/10/20.
//

import SwiftUI
import Combine

class CLImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct CLImage: View {
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? CLImage.defaultImage!)
            .resizable()
            .scaledToFit()
            .frame(minWidth: 75, maxWidth: .infinity, minHeight: 75, maxHeight: 350)
    }
    
    static var defaultImage = UIImage(named: "NewsIcon")
}

struct CLImage_Previews: PreviewProvider {
    static var previews: some View {
        CLImage(urlString: "https://apod.nasa.gov/apod/image/2009/M2D9_HubbleSchmidt_985.jpg")
    }
}

