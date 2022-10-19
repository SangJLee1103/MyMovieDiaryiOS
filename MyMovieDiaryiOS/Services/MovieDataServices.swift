//
//  MovieDataServices.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/19.
//

import Foundation
import Alamofire

class MovieDataServices {
    
    private let kobisURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    private let naverURL = "https://openapi.naver.com/v1/search/movie.json"
    
    func getBoxOffice(parameter: Parameters, completion: @escaping (KobisMovieList?, Error?) -> ()) {
        AF.request(kobisURL, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: KobisMovieList.self) { (response) in
                print(parameter)
                switch response.result {
                case .success(let response):
                    completion(response, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}
