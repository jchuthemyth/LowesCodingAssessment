//
//  MovieData.swift
//  LowesInterViewWeeChu
//
//  Created by Coding on 9/19/22.
//

import Foundation

struct MovieData: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String?
    var release_date: String?
    let vote_average: Double
    let poster_path: String?
    let overview: String?
}

enum CodingKeys: String, CodingKey {
    case posterPath = "poster_path"
    case voteAverage = "vote_average"
}
