//
//  ViewController.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/18.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    var viewModel: MovieViewModel = MovieViewModel()
    var disposableBag = Set<AnyCancellable>()
    
    var boxOfficeResult: [Item] = []
    var movieRankTitle: [String] = []
    
    private lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2 - 20) , height: 250)
        
        let movieChartCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        movieChartCollectionView.backgroundColor = .black
        movieChartCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        movieChartCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        movieChartCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return movieChartCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .black
        
        setupView()
        setLayout()
        setupSearchController()
        setBindings()
        
    }
}

extension MainViewController {
    private func setupView() {
        self.view.backgroundColor = .white
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.searchTextField.backgroundColor = .clear
        searchController.searchBar.placeholder = "영화를 검색하세요."
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "MyMovieDiary"
        self.navigationItem.titleView?.backgroundColor = .white
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(movieCollectionView)
        NSLayoutConstraint.activate ([
            movieCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            movieCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func configureCollectionView() {
        self.movieCollectionView.delegate = self
        self.movieCollectionView.dataSource = self
    }
}

// MARK: -뷰모델 관련
extension MainViewController {
    fileprivate func setBindings() {
        self.viewModel.getBoxOffice()
        
        // 박스오피스 영화이름
        viewModel.$movieTitles.sink { (movietitle: [String]) in
            self.movieRankTitle = movietitle
        }.store(in: &disposableBag)
        
        
        // 네이버 영화
        viewModel.$naverMovieList.sink { ( item: [Item]) in
            if item.count == 10 {
                self.boxOfficeResult += item
                self.configureCollectionView()
            }
        }.store(in: &disposableBag)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell  else { return UICollectionViewCell() }
        
        let movies = self.boxOfficeResult[indexPath.row]
        
        DispatchQueue.main.async {
            cell.prepare(rank: "1위", img: self.getThumbnail(imgUrl: movies.image), title: self.removeCharacter(title: movies.title), grade: movies.userRating)
        }
        
        return cell
        
    }
}

extension MainViewController {
    func removeCharacter(title: String) -> String{
        let titleResult = title.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
        return titleResult
    }
    
    func getThumbnail(imgUrl: String) -> UIImage {
        let sizeToImgUrl = imgUrl.replacingOccurrences(of: "mit110", with: "mit250")
        let url = URL(string: sizeToImgUrl)
        
        if let data = try? Data(contentsOf: url!) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        
        return UIImage()
    }
}

