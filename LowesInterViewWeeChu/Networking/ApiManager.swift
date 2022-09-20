//
//  ApiManager.swift
//  LowesInterViewWeeChu
//
//  Created by Coding on 9/19/22.
//

import Foundation
import UIKit

class ApiManager {
    
    private let API_KEY = "5885c445eab51c7004916b9c0313e2d3"
    
    func createURL(searchTerm: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/search/movie"
        components.queryItems = [
            URLQueryItem(name: "query", value: searchTerm),
            URLQueryItem(name: "api_key", value: API_KEY)
        ]
        
        guard let url = components.url else {
            return nil
        }
        print(url)
        return url
    }
    
    func getMovieData(searchTerm: String, completion: @escaping (MovieData?, Error?) -> Void) {
        
        guard let url = createURL(searchTerm: searchTerm) else {
            completion(nil, NetworkError.invalidURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, NetworkError.dataNotAvailable)
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            guard httpResponse.statusCode == 200 else {
                completion(nil, NetworkError.invalidResponse)
                return
            }
            
            do {
                let movieData = try JSONDecoder().decode(MovieData.self, from: data)
                completion(movieData, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case dataNotAvailable
    case invalidResponse
}
