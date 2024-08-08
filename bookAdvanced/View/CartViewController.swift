//
//  CartViewController.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/1/24.
//

import UIKit
import SnapKit

class CartViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var cartCollectionView: UICollectionView?
    private var cartBooks: [Book] = [] // 장바구니에 담긴 책 배열
    
    private let deleteAllButton = UIButton()
    private let titleLabel = UILabel()
    private let addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "장바구니"
        
        // 전체삭제 버튼 설정
        deleteAllButton.setTitle("전체삭제", for: .normal)
        deleteAllButton.setTitleColor(.lightGray, for: .normal)
        deleteAllButton.addTarget(self, action: #selector(deleteAllBooks), for: .touchUpInside)
        view.addSubview(deleteAllButton)
        
        // 담은 책 UILabel 설정
        titleLabel.text = "담은 책"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        // 추가 버튼 설정
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.systemGreen, for: .normal)
        addButton.addTarget(self, action: #selector(addMoreBooks), for: .touchUpInside)
        view.addSubview(addButton)
        
        // 장바구니 컬렉션 뷰 설정
        let cartLayout = UICollectionViewFlowLayout()
        cartLayout.scrollDirection = .vertical
        cartCollectionView = UICollectionView(frame: .zero, collectionViewLayout: cartLayout)
        cartCollectionView?.backgroundColor = .white
        cartCollectionView?.dataSource = self
        cartCollectionView?.delegate = self
        cartCollectionView?.register(CartBookCell.self, forCellWithReuseIdentifier: "cartBookCell")
        
        if let cartCollectionView = cartCollectionView {
            view.addSubview(cartCollectionView)
            cartCollectionView.snp.makeConstraints {
                $0.top.equalTo(deleteAllButton.snp.bottom).offset(20)
                $0.leading.trailing.bottom.equalToSuperview()
            }
        } else {
            print("Error: cartCollectionView is nil")
        }
        
        // UI 배치 설정
        deleteAllButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(deleteAllButton.snp.centerY)
            $0.centerX.equalToSuperview() // 화면 중앙에 배치
        }
        
        addButton.snp.makeConstraints {
            $0.centerY.equalTo(deleteAllButton.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // 전체삭제 버튼 액션
    @objc private func deleteAllBooks() {
        cartBooks.removeAll()
        cartCollectionView?.reloadData()
    }
    
    // 추가 버튼 액션
    @objc private func addMoreBooks() {
        // 메인 화면으로 이동
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 0 // 메인 화면(첫 번째 탭)으로 이동
            
            if let mainVC = tabBarController.viewControllers?.first as? MainViewController {
                mainVC.activateSearchBar() // 서치바를 활성화
            }
        }
    }
    
    // UICollectionViewDataSource 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartBookCell", for: indexPath) as? CartBookCell else {
            return UICollectionViewCell()
        }
        let book = cartBooks[indexPath.item]
        cell.configure(with: book)
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100) // 세로로 한 줄씩 표시
    }
    
    // 책 추가 메서드
    func addBookToCart(_ book: Book) {
        cartBooks.append(book)
        cartCollectionView?.reloadData()
    }
}
