//
//  MovieDataServices.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/19.
//

import Foundation
import Alamofire
import Combine

class MovieDataServices {
    
    private let kobisURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    private let naverURL = "https://openapi.naver.com/v1/search/movie.json"
    
    // 영화진흥위원회 서비스
    func getBoxOffice(parameter: Parameters, completion: @escaping ([DailyBoxOfficeList]?, Error?) -> ()) {
        AF.request(kobisURL, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: KobisMovieList.self) { (response) in
                switch response.result {
                case .success(let response):
                    completion(response.boxOfficeResult?.dailyBoxOfficeList, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    
    // 네이버 영화 검색서비스
    func getNaverMovie(parameter: Parameters, completion: @escaping ([Item]?, Error?) -> ()) {
        let header: HTTPHeaders = [
            "X-Naver-Client-Id":  Constants.naverClientId,
            "X-Naver-Client-Secret": Constants.naverClientSecret
        ]
        
        AF.request(naverURL, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: NaverMovieList.self) { (response) in
                switch response.result {
                case .success(let response):
                    completion(response.items, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}
