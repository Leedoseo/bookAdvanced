//
//  ViewController.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/1/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let mainLabel = UILabel()
    private let searchBar = UISearchBar()
    private let recentBook = UILabel()
    private var recentView: UICollectionView!
    private let searchResult = UILabel()
    private var searchView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
      
        view.addSubview(mainLabel)
        
        // 앱이름 뺄까? 고민중
        mainLabel.text = "앱 이름"
        mainLabel.textAlignment = .left
        mainLabel.textColor = .black
        mainLabel.font = UIFont.systemFont(ofSize: 28)
        
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(10)  // 레이블의 아래에 위치
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        searchBar.backgroundImage = UIImage()
        
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
        
        let recentLayout = UICollectionViewFlowLayout()
        recentLayout.scrollDirection = .horizontal
       
        recentView = UICollectionView(frame: .zero, collectionViewLayout: recentLayout)
        recentView.backgroundColor = .white
        recentView.dataSource = self
        recentView.delegate = self

        // 해당 코드는 더미이미지가 없어서 동그라미를 생성하기 위해 GPT로 작성한 코드, LV.2로 넘어가면 삭제 예정
        recentView.register(CircleCollectionViewCell.self, forCellWithReuseIdentifier: "circleCell")

        view.addSubview(recentView)
        
        recentView.snp.makeConstraints {
            $0.top.equalTo(recentBook.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)  // 원하는 높이로 설정
        }
        
        view.addSubview(searchResult)
        
        searchResult.text = "검색 결과"
        searchResult.textAlignment = .left
        searchResult.textColor = .black
        searchResult.font = UIFont.systemFont(ofSize: 28)
        
        searchResult.snp.makeConstraints {
            $0.top.equalTo(recentView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(28)
        }
        
        let searchLayout = UICollectionViewFlowLayout()
        searchLayout.scrollDirection = .vertical // 수직 스크롤
        
        searchView = UICollectionView(frame: .zero, collectionViewLayout: searchLayout)
        searchView.backgroundColor = .white
        searchView.dataSource = self
        searchView.delegate = self

        // 해당 코드는 더미이미지가 없어서 사각형을 생성하기 위해 GPT로 작성한 코드, LV.2로 넘어가면 삭제 예정
        // UICollectionViewCell의 커스텀 클래스인 SquareCollectionViewCell을 셀로 등록, 재사용 식별자는 "squareCell"
        searchView.register(SquareCollectionViewCell.self, forCellWithReuseIdentifier: "squareCell")
        
        view.addSubview(searchView)
        searchView.snp.makeConstraints {
            $0.top.equalTo(searchResult.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10) // 부모 뷰의 하단까지 확장
        }
    }
    
    // 아래 코드는 더미이미지가 없어서 일단 동그라미를 생성하기 위해 GPT로 작성한 코드, LV.2로 넘어가면 삭제 예정
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recentView {
            return 10 // 최근 본 책의 동그라미 수
        } else if collectionView == searchView {
            return 20 // 검색 결과 사각형 수
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == recentView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "circleCell", for: indexPath) as! CircleCollectionViewCell
            return cell
        } else if collectionView == searchView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "squareCell", for: indexPath) as! SquareCollectionViewCell
            return cell
        }
        return UICollectionViewCell()
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == recentView {
            return CGSize(width: 40, height: 40) // 동그라미 크기
        } else if collectionView == searchView {
            let width = collectionView.frame.width
            return CGSize(width: width, height: 80) // 사각형 크기
        }
        return CGSize.zero
    }

    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 셀이 선택되었을 때 모달로 열릴 뷰 컨트롤러 생성
        let modalViewController = BookInfoController()

        // 모달의 표현 스타일을 설정
        modalViewController.modalPresentationStyle = .pageSheet
        
        // 모달 창 표시
        present(modalViewController, animated: true, completion: nil)
    }
}

// MARK: - Custom UICollectionViewCell for Circle
// 해당 코드는 더미이미지가 없어서 동그라미를 생성하기 위해 GPT로 작성한 코드, LV.2로 넘어가면 삭제 예정
class CircleCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 동그라미 설정
        contentView.backgroundColor = .blue
        contentView.layer.cornerRadius = 20 // 동그라미 모양을 위해 절반으로 설정
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Custom UICollectionViewCell for Square
// 해당 코드는 더미이미지가 없어서 사각형을 생성하기 위해 GPT로 작성한 코드, LV.2로 넘어가면 삭제 예정
class SquareCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 사각형 설정
        contentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
