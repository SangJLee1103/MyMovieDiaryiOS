//
//  SearchMovieCell.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/25.
//

import UIKit

class SearchMovieCell: UITableViewCell {
    
    static let identifier = "SearchMovieCell"
    
    let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let movieNameLbl: UILabel = {
        let movieNameLbl = UILabel()
        movieNameLbl.sizeToFit()
        movieNameLbl.textColor = .white
        movieNameLbl.font = .systemFont(ofSize: 15)
        movieNameLbl.translatesAutoresizingMaskIntoConstraints = false
        return movieNameLbl
    }()
    
    let gradeLbl: UILabel = {
        let gradeLbl = UILabel()
        gradeLbl.sizeToFit()
        gradeLbl.textColor = .white
        gradeLbl.font = .systemFont(ofSize: 14)
        gradeLbl.translatesAutoresizingMaskIntoConstraints = false
        return gradeLbl
    }()
    
    let actorsLbl: UILabel = {
        let actorsLbl = UILabel()
        actorsLbl.sizeToFit()
        actorsLbl.textColor = .white
        actorsLbl.font = .systemFont(ofSize: 14)
        actorsLbl.translatesAutoresizingMaskIntoConstraints = false
        return actorsLbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .black
        self.contentView.backgroundColor = .black
        addContentView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView() {
        contentView.addSubview(imgView)
        contentView.addSubview(movieNameLbl)
        contentView.addSubview(gradeLbl)
        contentView.addSubview(actorsLbl)
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imgView.heightAnchor.constraint(equalToConstant: 50),
            imgView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            gradeLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            gradeLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            movieNameLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            movieNameLbl.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10),
            movieNameLbl.trailingAnchor.constraint(equalTo: gradeLbl.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            actorsLbl.topAnchor.constraint(equalTo: movieNameLbl.bottomAnchor, constant: 8),
            actorsLbl.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10),
            actorsLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}
