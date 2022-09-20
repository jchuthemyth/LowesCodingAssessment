//
//  ViewControllerViewModel.swift
//  LowesInterViewWeeChu
//
//  Created by Coding on 9/19/22.
//

import Foundation

class ViewControllerViewModel: FormatDateProtocol {
    
    let apiManager: ApiManager!
    private var movieCells = [Movie]() {
        didSet {
            self.reloadTable?()
        }
    }
    var reloadTable: (() -> ())?
    
    init(apiManager: ApiManager = ApiManager()){
        self.apiManager = apiManager
    }
    
    func fetchMovieData(searchTerm: String) {
        
        apiManager.getMovieData(searchTerm: searchTerm) { [weak self] movieData, error in
            guard let data = movieData, error == nil else {
                print(error ?? "Error at ViewControllerViewModel Loading Data")
                return
            }
            
            let movieInfo = data.results
            self?.processMovieData(movieInfo)
        }
        
    }
    
    func processMovieData(_ movies: [Movie]) {
        var cells = [Movie]()
        
        for movie in movies {
            var modifiedMovie = movie
            guard let releaseDate = modifiedMovie.release_date else {
                return
            }
            let dateString = formatDate(fromString: releaseDate, dateFormat: "yyyy-MM-dd")
            modifiedMovie.release_date = dateString
            cells.append(modifiedMovie)

        }
        
        movieCells = cells
    }
    
    
    func numberOfRow() -> Int {
        return movieCells.count
    }
    
    func getMovieCells() -> [Movie] {
        return movieCells
    }
}
