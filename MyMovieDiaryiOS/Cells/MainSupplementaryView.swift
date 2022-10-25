//
//  MainSupplementaryView.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/25.
//

import UIKit

final class MainSupplementaryView: UICollectionReusableView {
    
    static let identifier = "MainSupplementaryView"
    
    private let titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.textColor = .white
        titleLbl.font = .systemFont(ofSize: 17)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        return titleLbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(self.titleLbl)
        NSLayoutConstraint.activate([
            self.titleLbl.topAnchor.constraint(equalTo: topAnchor),
            self.titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            self.titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.titleLbl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(title: nil)
        self.backgroundColor = .black
    }
    
    func prepare(title: String?) {
        self.titleLbl.text = title
    }
}
