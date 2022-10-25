//
//  DateUtil.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/23.
//

import Foundation

class DateUtil {
    
    static func getCurrentDateTime(now: Date) -> String{
        let formatter = DateFormatter() //객체 생성
        let yesterday = now - 86400
        
        formatter.dateFormat = "yyyyMMdd" //데이터 포멧 설정
        let result = formatter.string(from: yesterday)
        return result
    }
    
    // 년도만 뽑는 유틸 함수
    static func getYear(year: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let result  = formatter.string(from: year)
        return result
    }
}
