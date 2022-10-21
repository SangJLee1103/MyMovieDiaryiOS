//
//  ViewController.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/18.
//

import UIKit
import RxSwift
import RxRelay

class MainViewController: UIViewController {
    
    let viewModel: MovieViewModel
    let disposeBag = DisposeBag()
    
    let dailyBoxOfficeViewModel = BehaviorRelay<[DailyBoxOfficeViewModel]>(value: [])
    let naverMovieViewModel = BehaviorRelay<[NaverMovieViewModel]>(value: [])
    
    var dailyBoxOfficeVmObserver: Observable<[DailyBoxOfficeViewModel]> {
        return dailyBoxOfficeViewModel.asObservable()
    }
    
    var naverMovieVmObserver: Observable<[NaverMovieViewModel]> {
        return naverMovieViewModel.asObservable()
    }
    
    // 의존성 주입
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var boxOfficeMovieNm: Array<String> = Array()
    private lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) , height: 250)
        
        let movieChartCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        movieChartCollectionView.backgroundColor = .black
        movieChartCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        movieChartCollectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 0)
        movieChartCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return movieChartCollectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        setLayout()
        configureCollectionView()
        getBoxOffice()
        subscribe()
        print(self.boxOfficeMovieNm)
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
            movieCollectionView.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    func configureCollectionView() {
        self.movieCollectionView.delegate = self
        self.movieCollectionView.dataSource = self
    }
}

extension MainViewController {
    
    // 영화 일일 박스오피스 호출 로직
    func getBoxOffice() {
        let kobisParameter: [String: String] = [
            "key": Constants().kobisKey,
            "targetDt": "20221018"
        ]

        self.viewModel.getBoxOffices(parameter: kobisParameter).subscribe(onNext: { dailyBoxOfficeViewModel in
            self.dailyBoxOfficeViewModel.accept(dailyBoxOfficeViewModel)
        }).disposed(by: disposeBag)
    }
    
    func getNaverMovie() {
        
        
    }
    
    func subscribe() {
//        self.dailyBoxOfficeVmObserver.subscribe(onNext: { boxOfficeResults in
//            print(boxOfficeResults)
//        }).disposed(by: disposeBag)
        self.dailyBoxOfficeVmObserver.subscribe(onNext: { boxOfficeResults in
            boxOfficeResults.map{ $0.movieNm}
        })
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell  else { return UICollectionViewCell() }
        cell.prepare(rank: "1위", img: UIImage(systemName: "chevron.left"), title: "ㅋㅋ", grade: "4.5")
        return cell
    }
}
