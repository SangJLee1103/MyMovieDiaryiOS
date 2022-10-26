//
//  MovieDetailViewController.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/23.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var image: String = ""
    var movieTitle: String = ""
    var director: String = ""
    var actor: String = ""
    var userRating: String = ""
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let directorLbl: UILabel = {
        let directorLbl = UILabel()
        directorLbl.translatesAutoresizingMaskIntoConstraints = false
        directorLbl.textColor = .white
        directorLbl.font = .systemFont(ofSize: 16)
        return directorLbl
    }()
    
    private let userRatingLbl: UILabel = {
        let userRatingLbl = UILabel()
        userRatingLbl.translatesAutoresizingMaskIntoConstraints = false
        return userRatingLbl
        
    }()
    
    private let actorLbl: UILabel = {
        let actorLbl = UILabel()
        actorLbl.translatesAutoresizingMaskIntoConstraints = false
        actorLbl.textColor = .white
        actorLbl.numberOfLines = 2
        actorLbl.font = .systemFont(ofSize: 16)
        return actorLbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setLayout()
        imageView.contentMode = .scaleToFill
        ImageUtil.getThumbnail(imgUrl: image) { (image) in
            DispatchQueue.main.async {
                if let image = image {
                    self.imageView.image = image
                }
            }
        }
    }
}

extension MovieDetailViewController {
    private func setupView() {
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = self.movieTitle
    }
    
    private func setLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 2.0 / 5.0),
        ])
        
        view.addSubview(directorLbl)
        NSLayoutConstraint.activate([
            directorLbl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            directorLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        ])
        directorLbl.text = "감독  \(self.director)"
        
        if actor.count > 0 {
            view.addSubview(actorLbl)
            
            NSLayoutConstraint.activate([
                actorLbl.topAnchor.constraint(equalTo: directorLbl.bottomAnchor, constant: 5),
                actorLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                actorLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
            ])
            actorLbl.text = "출연  \(self.actor)"
        }
    }
}


