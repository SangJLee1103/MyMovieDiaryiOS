//
//  Constants.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/19.
//

import Foundation

struct Constants {
    static let kobisKey = Bundle.main.infoDictionary?["KOBIS_API_KEY"] as? String ?? ""
    static let naverClientId = Bundle.main.infoDictionary?["NAVER_CLIENT_ID"] as? String ?? ""
    static let naverClientSecret = Bundle.main.infoDictionary?["NAVER_CLIENT_SECRET"] as? String ?? ""
    static let kakaoKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String ?? ""
}
