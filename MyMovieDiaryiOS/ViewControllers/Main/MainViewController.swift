//
//  ViewController.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/18.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    var boxOfficeViewModel: MovieViewModel = MovieViewModel()
    var searchViewModel: MovieSearchViewModel = MovieSearchViewModel()
    
    var disposableBag = Set<AnyCancellable>()
    
    var boxOfficeResult: [Item] = []
    var movieRankTitle: [String] = []
    var searchMovieList: [Item] = []
    
    var searchMode: Bool = false // 검색창 활성화 여부
    
    var searchController: UISearchController!
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        // Create an indicator.
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = self.view.center
        // Also show the indicator even when the animation is stopped.
        activityIndicator.hidesWhenStopped = false
        activityIndicator.color = .white
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        // Start animation.
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // 영화 박스오피스 컬렉션 뷰
    private lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2 - 30) , height: 300)
        layout.headerReferenceSize = .init(width: 100, height: 30)
        
        let movieChartCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        movieChartCollectionView.backgroundColor = .black
        movieChartCollectionView.register(MainSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainSupplementaryView.identifier)
        movieChartCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        movieChartCollectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        movieChartCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return movieChartCollectionView
    }()
    
    // 영화 검색 테이블 뷰
    private lazy var searchMovieTableView: UITableView = {
        let searchMovieTableView = UITableView()
        searchMovieTableView.register(SearchMovieCell.self, forCellReuseIdentifier: SearchMovieCell.identifier)
        searchMovieTableView.backgroundColor = .black
        searchMovieTableView.separatorStyle = .none
        searchMovieTableView.isUserInteractionEnabled = true
        searchMovieTableView.isScrollEnabled = true
        searchMovieTableView.translatesAutoresizingMaskIntoConstraints = false
        return searchMovieTableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "MovieYA"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setLayout()
        self.view.addSubview(self.activityIndicator)
        setBindings()
        setupSearchController()
        configureCollectionView()
        configureTableView()
    }
}

// MARK: - 레이아웃 관련
extension MainViewController {
    private func setupView() {
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.barTintColor = .black
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
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
    
    private func searchTableViewLayout(){
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(searchMovieTableView)
        NSLayoutConstraint.activate([
            searchMovieTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchMovieTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchMovieTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            searchMovieTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func configureCollectionView() {
        self.movieCollectionView.delegate = self
        self.movieCollectionView.dataSource = self
    }
    
    func configureTableView() {
        self.searchMovieTableView.delegate = self
        self.searchMovieTableView.dataSource = self
    }
}

// MARK: - 뷰모델 관련
extension MainViewController {
    fileprivate func setBindings() {
        self.boxOfficeViewModel.getBoxOffice()
        
        // 박스오피스 영화이름
        boxOfficeViewModel.$movieTitles.sink { (movietitle: [String]) in
            self.movieRankTitle = movietitle
        }.store(in: &disposableBag)
        
        // 네이버 영화
        boxOfficeViewModel.$naverMovieList.sink { ( item: [Item]) in
            if item.count == 10 {
                self.boxOfficeResult = item
                self.movieCollectionView.reloadData()
            }
        }.store(in: &disposableBag)
        
        // 검색결과
        searchViewModel.$searchMovieList.sink { (item: [Item]) in
            self.searchMovieList = item
            self.searchMovieTableView.reloadData()
        }.store(in: &disposableBag)
    }
}


// MARK: - 컬렉션 뷰 관련
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.boxOfficeResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainSupplementaryView.identifier, for: indexPath) as! MainSupplementaryView
            header.prepare(title: "오늘의 박스오피스")
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell  else { return UICollectionViewCell() }
        let movies = self.boxOfficeResult[indexPath.row]
        
        ImageUtil.getThumbnail(imgUrl: movies.image) { (image) in
            DispatchQueue.main.async {
                if let image = image {
                    cell.imgView.image = image
                }
            }
        }
        cell.prepare(title: StringUtil.removeCharacter(title: movies.title), grade: movies.userRating)
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
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

// MARK: - UISearchViewController 델리게이트
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            return
        } else {
            if searchController.searchBar.text == "" {
                searchMode = false
                DispatchQueue.main.async {
                    self.searchMovieTableView.reloadData()
                }
            } else {
                searchMode = true
                searchTableViewLayout()
            }
        }
        self.searchMovieList.removeAll()
        self.searchViewModel.getSearchMovieList(query: searchController.searchBar.text ?? "")
        DispatchQueue.main.async {
            self.searchMovieTableView.reloadData()
        }
    }
}


extension MainViewController: UISearchControllerDelegate, UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if let search = searchController.searchBar.text {
//        }
//    }
    
    // cancel 클릭시 검색 테이블 뷰 제거
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchMovieTableView.removeFromSuperview()
        self.searchMovieList.removeAll()
    }
}


// MARK: - 영화 검색결과 테이블 뷰 델리게이트, 데이터소스
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.searchMode {
        case true:
            let searchList = self.searchMovieList[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieCell.identifier, for: indexPath) as? SearchMovieCell else { fatalError("no matched articleTableViewCell identifier") }
            cell.selectionStyle = .none
            ImageUtil.getThumbnail(imgUrl: searchList.image) { (image) in
                DispatchQueue.main.async {
                    if let image = image {
                        cell.imgView.image = image
                    }
                }
            }
            cell.movieNameLbl.text = StringUtil.removeCharacter(title: searchList.title)
            cell.gradeLbl.text = "⭐️ \(searchList.userRating)"
            cell.actorsLbl.text = "출연: \(StringUtil.removePersonCharacter(actor: searchList.actor))"
            return cell
        case false:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchList = self.searchMovieList[indexPath.row]
        let nextVC = MovieDetailViewController()
        nextVC.image = searchList.image
        nextVC.movieTitle = StringUtil.removeCharacter(title: searchList.title)
        nextVC.actor = StringUtil.removePersonCharacter(actor: searchList.actor)
        nextVC.director = StringUtil.removePersonCharacter(actor: searchList.director)
        nextVC.userRating = searchList.userRating
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


