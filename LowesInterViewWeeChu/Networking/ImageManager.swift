//
//  ImageManager.swift
//  LowesInterViewWeeChu
//
//  Created by Coding on 9/20/22.
//

import UIKit
import Foundation

class ImageManager {
    
    private let imageCache = NSCache<NSString, UIImage>()
    private let urlPath = "https://image.tmdb.org/t/p/w300"
    
    func getImage(imagePath: String, completion: @escaping (UIImage?, Error?) -> Void) {
        if let image = imageCache.object(forKey: "image") {
            completion(image, nil)
            return
        }
        
        guard let url = URL(string: urlPath + imagePath) else {
            completion(nil, NetworkError.invalidURL)
            return
        }
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(nil, NetworkError.dataNotAvailable)
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    completion(nil, NetworkError.dataNotAvailable)
                    return
                }
                self?.imageCache.setObject(image, forKey: "image")
                completion(image, nil)
            }
        }
        task.resume()
    }
}
