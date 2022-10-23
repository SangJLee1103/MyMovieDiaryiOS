//
//  MovieCell.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/18.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    
    private let rankingLbl: UILabel = {
        let rankingLbl = UILabel()
        rankingLbl.sizeToFit()
        rankingLbl.textColor = .white
        rankingLbl.font = .systemFont(ofSize: 15)
        rankingLbl.translatesAutoresizingMaskIntoConstraints = false
        return rankingLbl
    }()
    
    private let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.sizeToFit()
        titleLbl.numberOfLines = 2
        titleLbl.textAlignment = .center
        titleLbl.textColor = .white
        titleLbl.font = .systemFont(ofSize: 15)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        return titleLbl
    }()
    
    private let gradeLbl: UILabel = {
        let gradeLbl = UILabel()
        gradeLbl.sizeToFit()
        gradeLbl.textAlignment = .center
        gradeLbl.textColor = .white
        gradeLbl.font = .systemFont(ofSize: 13)
        gradeLbl.translatesAutoresizingMaskIntoConstraints = false
        return gradeLbl
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addContentView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView() {
//        addSubview(rankingLbl)
        addSubview(imgView)
        addSubview(titleLbl)
        addSubview(gradeLbl)
    }
    
    private func setLayout(){
        
//        NSLayoutConstraint.activate([
//            rankingLbl.topAnchor.constraint(equalTo: topAnchor),
//            rankingLbl.leadingAnchor.constraint(equalTo: leadingAnchor)
//        ])
//
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 10),
            titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            gradeLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 5),
            gradeLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            gradeLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5)
        ])
    }
    
    func prepare(rank: String?, img: UIImage?, title: String, grade: String) {
        self.rankingLbl.text = rank
        self.imgView.image = img
        self.titleLbl.text = title
        self.gradeLbl.text = "⭐️ \(grade)"
    }
}
