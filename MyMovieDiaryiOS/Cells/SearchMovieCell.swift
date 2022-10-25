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
        movieNameLbl.
        return movieNameLbl
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
