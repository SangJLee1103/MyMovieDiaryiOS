//
//  BoxOfficeViewModel.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/21.
//

import Foundation

struct DailyBoxOfficeViewModel {
    private let dailyBoxOffice: DailyBoxOfficeList
    
    init(dailyBoxOffice: DailyBoxOfficeList) {
        self.dailyBoxOffice = dailyBoxOffice
    }
    
    var movieNm: String? {
        return dailyBoxOffice.movieNm
    }
}
