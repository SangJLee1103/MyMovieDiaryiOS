//
//  StringUtil.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/23.
//

import Foundation

struct StringUtil {
    
    // 네이버 영화 타이틀 <b></b>제거
    static func removeCharacter(title: String) -> String {
         return title.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
    }
    
    // 네이버 영화 감독 및 배우 |구분 제거
    static func removePersonCharacter(actor: String) -> String {
        return String(actor.replacingOccurrences(of: "|", with: ", ").dropLast(2))
    }
}
