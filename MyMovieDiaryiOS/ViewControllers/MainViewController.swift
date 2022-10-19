//
//  ViewController.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/18.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) , height: 250)
        
        let movieChartCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        movieChartCollectionView.backgroundColor = .black
        movieChartCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        movieChartCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        movieChartCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return movieChartCollectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parameter: [String: String] = [
            "key": Constants.kobisKey ?? "",
            "targetDt": "20221018"
        ]
            
        
        setupView()
        setLayout()
        configureCollectionView()
        MovieDataServices().getBoxOffice(parameter: parameter) { (result, error) in
            if let result = result {
                print(result)
            } else {
                print("없노")
            }
        }
    }
}

extension MainViewController {
    private func setupView() {
        self.view.backgroundColor = .black
    }
    
    private func setLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(movieCollectionView)
        NSLayoutConstraint.activate ([
            movieCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            movieCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            movieCollectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    
    func configureCollectionView() {
        self.movieCollectionView.delegate = self
        self.movieCollectionView.dataSource = self
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell  else { return UICollectionViewCell() }
        cell.titleLbl.text = "씨바"
        cell.prepare(img: UIImage(systemName: "chevron.left"), title: "ㅋㅋ", grade: "4.5")
        return cell
    }
}
