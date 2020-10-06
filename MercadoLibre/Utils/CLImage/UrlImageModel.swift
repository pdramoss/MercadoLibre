//
//  UrlImageModel.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 8/10/20.
//

import Foundation
import SwiftUI

class UrlImageModel: ObservableObject {
    @Published var image: UIImage?
    var urlString: String
    var imageCache = ImageCache.getImageCache()
    
    init(urlString: String = String()) {
        self.urlString = urlString
        loadImage()
    }
    
    private func loadImage() {
        if loadImageFromCache() {
            Logger.info("Cache hit")
            return
        }
        
        Logger.info("Cache miss, loading from url")
        loadImageFromUrl()
    }
    
    private func loadImageFromCache() -> Bool {
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        image = cacheImage
        return true
    }
    
    private func loadImageFromUrl() {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }
    
    
    private func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            Logger.info("Error: \(String(describing: error))")
            return
        }
        guard let data = data else {
            Logger.info("No data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            
            self.imageCache.set(forKey: self.urlString, image: loadedImage)
            self.image = loadedImage
        }
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
