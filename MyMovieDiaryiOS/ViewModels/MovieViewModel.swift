//
//  MovieViewModel.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/20.
//

import Foundation
import RxSwift
import Alamofire

final class MovieViewModel {
    
    private let boxOfficeService:MovieDataServicesProtocol
    private let naverService: MovieDataServicesProtocol
    
    init(boxOfficeService: MovieDataServicesProtocol, naverService: MovieDataServicesProtocol) {
        self.boxOfficeService = boxOfficeService
        self.naverService = naverService
    }
    
    
    func getBoxOffices(parameter: Parameters) -> Observable<[DailyBoxOfficeViewModel]> {
        boxOfficeService.getBoxOffice(parameter: parameter).map { $0.map {
            DailyBoxOfficeViewModel(dailyBoxOffice: $0)
        }}
    }
    
    func getNaverMovie(parameter: Parameters) -> Observable<[NaverMovieViewModel]> {
        naverService.getNaverMovie(parameter: parameter).map { $0.map {
            NaverMovieViewModel(item: $0)
        }}
    }
    
//    func getBoxOfficeAndNaverMovie(parameter: Parameters) -> Observable<[NaverMovieViewModel]> {
//        boxOfficeService.getBoxOffice(parameter: parameter).flatMap { result in
//            return  naverService.getNaverMovie(parameter: result.map{ $0.movieNm })
//
//        }
//    }
    
    
}
