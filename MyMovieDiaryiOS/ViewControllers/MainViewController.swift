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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "MovieYA"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .black
        
        setupView()
        setLayout()
        setBindings()
        setupSearchController()
    }
}

extension MainViewController {
    private func setupView() {
        self.view.backgroundColor = .black
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.barStyle = .black
        searchController.searchBar.tintColor = .white
        searchController.searchBar.placeholder = "영화를 검색하세요."
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(movieCollectionView)
        NSLayoutConstraint.activate ([
            movieCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
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
            cell.prepare(rank: "1위", img: ImageUtil.getThumbnail(imgUrl: movies.image), title: StringUtil.removeCharacter(title: movies.title), grade: movies.userRating)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movies = self.boxOfficeResult[indexPath.row]
        let nextVC = MovieDetailViewController()
        nextVC.image = movies.image
        nextVC.movieTitle = StringUtil.removeCharacter(title: movies.title)
        nextVC.actor = StringUtil.removePersonCharacter(actor: movies.actor)
        nextVC.director = StringUtil.removePersonCharacter(actor: movies.director)
        nextVC.userRating = movies.userRating
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

