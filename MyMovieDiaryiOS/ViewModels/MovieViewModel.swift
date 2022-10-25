//
//  MovieViewModel.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/20.
//

import Foundation
import Combine
import Alamofire


// MARK: - 메인 영화 박스오피스에 대한 뷰 모델
class MovieViewModel {
    @Published var naverMovieList: [Item] = []
    @Published var movieTitles: [String] = []
}

extension MovieViewModel {
    func getBoxOffice() {
        let kobisParameter: [String: String] = [
            "key": Constants().kobisKey,
            "targetDt": DateUtil.getCurrentDateTime(now: Date())
        ]
        
        MovieDataServices().getBoxOffice(parameter: kobisParameter) { (boxOffice, error) in
            if let boxOffice = boxOffice {
                self.movieTitles = boxOffice.map {$0.movieNm}
                for i in 0..<boxOffice.count {
                    let parameter: [String: String] = [
                        "query": boxOffice.map{ $0.movieNm }[i],
                        "Display": "1",
                        "yearfrom": DateUtil.getYear(year: Date())
                    ]

                    MovieDataServices().getNaverMovie(parameter: parameter) { (movie, error) in
                        if let movie = movie {
                            self.naverMovieList.append(contentsOf: movie)
                            print(self.naverMovieList)
                        }
                    }
                }
            }
        }
    }
}
