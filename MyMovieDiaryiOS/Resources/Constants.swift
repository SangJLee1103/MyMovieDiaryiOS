//
//  Constants.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/19.
//

import Foundation

struct Constants {
    static let kobisKey = Bundle.main.infoDictionary?["KOBIS_API_KEY"] as? String
    static let naverClientId = Bundle.main.infoDictionary?["NAVER_CLENT_ID"]
    static let naverClientSecret = Bundle.main.infoDictionary?["NAVER_CLIENT_SECRET"]
}
