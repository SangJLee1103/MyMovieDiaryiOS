//
//  BottomBtn.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/11/03.
//

import Foundation

// MARK: - 
protocol BottomButtonProtocol {
    func tapButton()
}

class BottomButton: UIButton {
    
    var delegate: BottomButtonProtocol?
   
    
    
    func setupView(title: String) {
        self.backgroundColor = .red
        self.setTitleColor(.white, for: .normal)
        self.setTitle(title, for: .normal)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addTarget(self, action: #selector(didTapThisButton), for: .touchUpInside)
    }
}

extension BottomButton {
    @objc func didTapThisButton() {
        delegate?.tapButton()
    }
}
