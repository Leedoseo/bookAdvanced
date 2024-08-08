//
//  ViewController.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/1/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, BookInfoControllerDelegate {
    
    private let searchBar = UISearchBar()
    private var collectionView: UICollectionView!
    private let recentBooksViewController = RecentBooksController() // 최근 본 책 뷰 컨트롤러 추가
    
    private let viewModel = SearchViewModel()
    
    private let mainLabel = UILabel()
    private let recentBook = UILabel()
    private let searchResult = UILabel()
    
    var cartViewController: CartViewController? // CartViewController 인스턴스를 참조하기 위해 사용
    
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
        
        // 최근 본 책 컬렉션 뷰 컨트롤러 추가
        addChild(recentBooksViewController)
        view.addSubview(recentBooksViewController.view)
        recentBooksViewController.view.snp.makeConstraints {
            $0.top.equalTo(recentBook.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }
        recentBooksViewController.didMove(toParent: self)
        
        // 검색 결과 레이블
        view.addSubview(searchResult)
        searchResult.text = "검색 결과"
        searchResult.textAlignment = .left
        searchResult.textColor = .black
        searchResult.font = UIFont.systemFont(ofSize: 28)
        searchResult.snp.makeConstraints {
            $0.top.equalTo(recentBooksViewController.view.snp.bottom).offset(30)
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
        return viewModel.getBooks().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! BookCollectionViewCell
        let book = viewModel.getBooks()[indexPath.item]
        cell.configure(with: book) // 검색 결과 전용 설정
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = viewModel.getBooks()[indexPath.item]
        
        // 최근 본 책 추가
        recentBooksViewController.updateWithBook(selectedBook)

        // BookInfoController 인스턴스를 생성하고 선택된 책 정보를 전달
        let modalViewController = BookInfoController()
        modalViewController.book = selectedBook
        modalViewController.delegate = self
        
        // 모달의 표현 스타일을 설정하고, 모달 창을 표시
        modalViewController.modalPresentationStyle = .pageSheet
        present(modalViewController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 150) // 검색 결과 사각형 크기
    }

    func didAddBook(_ book: Book) {
        cartViewController?.addBookToCart(book)
        // 알림 창을 제거하여, 이 메서드는 단순히 책을 장바구니에 추가하는 역할만 합니다.
    }
    
    // 검색 바를 활성화하는 메서드
    func activateSearchBar() {
        searchBar.becomeFirstResponder() // 서치바를 활성화
    }
}
