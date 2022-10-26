//
//  SearchMovieCell.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/25.
//

import UIKit

class SearchMovieCell: UITableViewCell {
    
    static let identifier = "SearchMovieCell"
    
    private let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let movieNameLbl: UILabel = {
        let movieNameLbl = UILabel()
        movieNameLbl.sizeToFit()
        movieNameLbl.textColor = .white
        movieNameLbl.font = .systemFont(ofSize: 15)
        return movieNameLbl
    }()
    
    private let gradeLbl: UILabel = {
        let gradeLbl = UILabel()
        gradeLbl.sizeToFit()
        gradeLbl.textColor = .white
        gradeLbl.font = .systemFont(ofSize: 14)
        return gradeLbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView() {
        contentView.addSubview(imgView)
        contentView.addSubview(movieNameLbl)
        contentView.addSubview(gradeLbl)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imgView.heightAnchor.constraint(equalToConstant: 45),
            imgView.widthAnchor.constraint(equalToConstant: 45)
        ])
        
    }
    
    
}
