//
//  MovieList.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/19.
//

import Foundation


// MARK: - 영화진흥위원회 모델
struct KobisMovieList: Codable {
    let boxOfficeResult: BoxOfficeResult?
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rank: String // 영화순위
    let movieCD: String // 영화 대표코드
    let movieNm: String // 영화명
    let openDt: String // 개봉일
    let salesAcc: String // 누적 매출액
    let audiAcc: String // 누적 관객수

    enum CodingKeys: String, CodingKey {
        case rank
        case movieCD = "movieCd"
        case movieNm, openDt, salesAcc, audiAcc
    }
}


// MARK: - 네이버영화 모델
struct NaverMovieList: Codable {
    let lastBuildDate: String
    let total, display: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String // 영화명
    let link: String // 네이버 영화 정보 URL
    let image: String // 영화 썸네일 URL
    let subtitle, pubDate, director, actor: String // 부제, 제작년도,감독, 배우들
    let userRating: String // 평점
}


