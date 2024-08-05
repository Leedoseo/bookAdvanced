//
//  ViewController.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/1/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let searchBar = UISearchBar()
    private var collectionView: UICollectionView!
    private var recentCollectionView: UICollectionView!
    private let viewModel = SearchViewModel()
    
    // 기존 UI 요소들
    private let mainLabel = UILabel()
    private let recentBook = UILabel()
    private let searchResult = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        viewModel.onBooksUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white

        // 메인 레이블
        view.addSubview(mainLabel)
        mainLabel.text = "앱 이름"
        mainLabel.textAlignment = .left
        mainLabel.textColor = .black
        mainLabel.font = UIFont.systemFont(ofSize: 28)
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }

        // 검색 바
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        // 최근 본 책 레이블
        view.addSubview(recentBook)
        recentBook.text = "최근 본 책"
        recentBook.textAlignment = .left
        recentBook.textColor = .black
        recentBook.font = UIFont.systemFont(ofSize: 28)
        recentBook.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(28)
        }
        
        // 최근 본 책 컬렉션 뷰
        let recentLayout = UICollectionViewFlowLayout()
        recentLayout.scrollDirection = .horizontal
        recentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: recentLayout)
        recentCollectionView.backgroundColor = .white
        recentCollectionView.dataSource = self
        recentCollectionView.delegate = self
        recentCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "recentBookCell")
        view.addSubview(recentCollectionView)
        recentCollectionView.snp.makeConstraints {
            $0.top.equalTo(recentBook.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }
        
        // 검색 결과 레이블
        view.addSubview(searchResult)
        searchResult.text = "검색 결과"
        searchResult.textAlignment = .left
        searchResult.textColor = .black
        searchResult.font = UIFont.systemFont(ofSize: 28)
        searchResult.snp.makeConstraints {
            $0.top.equalTo(recentCollectionView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(28)
        }
        
        // 검색 결과 컬렉션 뷰
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "bookCell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchResult.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        viewModel.searchBooks(query: query)
        searchBar.resignFirstResponder() // 키보드 닫기
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recentCollectionView {
            return 10 // 예시로, 최근 본 책의 수를 10으로 설정
        } else if collectionView == self.collectionView {
            return viewModel.getBooks().count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == recentCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentBookCell", for: indexPath) as! BookCollectionViewCell
            // 예시 데이터로 셀을 구성
            cell.configure(with: Book(title: "최근 본 책 \(indexPath.item + 1)", authors: ["저자 \(indexPath.item + 1)"], thumbnail: ""))
            return cell
        } else if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! BookCollectionViewCell
            let book = viewModel.getBooks()[indexPath.item]
            cell.configure(with: book)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == recentCollectionView {
            return CGSize(width: 100, height: 150) // 최근 본 책 셀 크기
        } else if collectionView == self.collectionView {
            let width = collectionView.frame.width
            return CGSize(width: width, height: 150) // 검색 결과 사각형 크기
        }
        return CGSize.zero
    }
}
