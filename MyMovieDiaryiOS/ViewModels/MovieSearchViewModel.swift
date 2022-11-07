//
//  MovieSearchViewModel.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/23.
//

import Foundation
import Alamofire

class MovieSearchViewModel {
    @Published var searchMovieList: [Item] = []
}

extension MovieSearchViewModel {
    func getSearchMovieList(query: String) {
        let parameter: [String: Any] = [
            "query": query,
            "display": 100
        ]
        
        MovieDataServices().getNaverMovie(parameter: parameter) { (item, error) in
            if let item = item {
                self.searchMovieList = item
            }
        }
        
    }
}
