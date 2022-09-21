//
//  ImageManager.swift
//  LowesInterViewWeeChu
//
//  Created by Coding on 9/20/22.
//

import UIKit
import Foundation

//MARK: Image API
class ImageManager {
    

    private let urlPath = "https://image.tmdb.org/t/p/w300"
    
    func getImage(imagePath: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        guard let url = URL(string: urlPath + imagePath) else {
            completion(nil, NetworkError.invalidURL)
            return
        }
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil, NetworkError.dataNotAvailable)
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    completion(nil, NetworkError.dataNotAvailable)
                    return
                }
                completion(image, nil)
            }
        }
        task.resume()
    }
}
