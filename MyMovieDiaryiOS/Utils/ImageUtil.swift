//
//  ImageUtil.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/23.
//

import UIKit

struct ImageUtil {
    static func getThumbnail(imgUrl: String, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async {
            let sizeToImgUrl = imgUrl.replacingOccurrences(of: "mit110", with: "mit500")
            if let url = URL(string: sizeToImgUrl) {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        completion(image)
                    }
                }
            }else {
                completion(UIImage(named: "thum"))
            }
        }
    }
}
