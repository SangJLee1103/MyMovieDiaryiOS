//
//  MovieViewModel.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/20.
//

import Foundation
import Combine
import Alamofire

class MovieViewModel {
    @Published var naverMovieList: [Item] = []
    @Published var movieTitles: [String] = []
    
    let kobisParameter: [String: String] = [
        "key": Constants().kobisKey,
        "targetDt": "20221018"
    ]
}

extension MovieViewModel {
    func getBoxOffice() {
        MovieDataServices().getBoxOffice(parameter: kobisParameter) { (boxOffice, error) in
            if let boxOffice = boxOffice {
                self.movieTitles = boxOffice.map {$0.movieNm}
                for i in 0..<boxOffice.count {
                    let parameter: [String: String] = [
                        "query": boxOffice.map{ $0.movieNm }[i],
                        "Display": "1",
                        "yearfrom":"2022"
                    ]

                    MovieDataServices().getNaverMovie(parameter: parameter) { (movie, error) in
                        if let movie = movie { 
                            self.naverMovieList.append(contentsOf: movie)
                        }
                    }
                }
            }
        }
    }
}
