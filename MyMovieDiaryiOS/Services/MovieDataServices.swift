//
//  MovieDataServices.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/19.
//

import Foundation
import Alamofire
import RxSwift


protocol MovieDataServicesProtocol {
    func getBoxOffice(parameter: Parameters) -> Observable<[DailyBoxOfficeList]>
    func getNaverMovie(parameter: Parameters) -> Observable<[Item]>
} 

class MovieDataServices: MovieDataServicesProtocol {
    
    private let kobisURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    private let naverURL = "https://openapi.naver.com/v1/search/movie.json"
    
    
    func getBoxOffice(parameter: Parameters) -> Observable<[DailyBoxOfficeList]> {
        return Observable.create { (observer) -> Disposable in
            self.getBoxOffice(parameter: parameter) { (response, error) in
                if let response = response {
                    observer.onNext(response)
                }
                
                if let error = error {
                    observer.onError(error)
                }
                
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
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
    
    
    func getNaverMovie(parameter: Parameters) -> Observable<[Item]> {
        return Observable.create { (observer) -> Disposable in
            self.getNaverMovie(parameter: parameter) { (response, error) in
                if let response = response {
                    observer.onNext(response)
                }
                
                if let error = error {
                    observer.onError(error)
                }
                
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    
    func getNaverMovie(parameter: Parameters, completion: @escaping ([Item]?, Error?) -> ()) {
        let header: HTTPHeaders = [
            "X-Naver-Client-Id":  Constants().naverClientId,
            "X-Naver-Client-Secret": Constants().naverClientSecret
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
