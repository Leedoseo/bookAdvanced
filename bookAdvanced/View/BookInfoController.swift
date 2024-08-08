//
//  BookInfoController.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/1/24.
//

//
//  BookInfoController.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/1/24.
//

import UIKit
import SnapKit

protocol BookInfoControllerDelegate: AnyObject {
    func didAddBook(_ book: Book)
}

class BookInfoController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let thumbnailImageView = UIImageView()
    private let priceLabel = UILabel()
    private let contentsLabel = UILabel()

    private let addButton = UIButton()
    private let closeButton = UIButton()
    
    var book: Book? // 선택된 책 정보를 저장
    weak var delegate: BookInfoControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayBookInfo()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        // 스크롤 뷰 설정
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(view.frame.width)
        }
        
        // 제목 레이블 설정
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)

        // 저자 레이블 설정
        authorLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        authorLabel.textAlignment = .center
        contentView.addSubview(authorLabel)
        
        // 이미지 뷰 설정
        thumbnailImageView.contentMode = .scaleAspectFit
        contentView.addSubview(thumbnailImageView)
        
        // 가격 레이블 설정
        priceLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        priceLabel.textAlignment = .center
        contentView.addSubview(priceLabel)

        // 설명 레이블 설정
        contentsLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        contentsLabel.numberOfLines = 0
        contentView.addSubview(contentsLabel)
        
        // 오토 레이아웃 설정
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        thumbnailImageView.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.height.equalTo(thumbnailImageView.snp.width).multipliedBy(1.2)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-70)
        }
        
        // 플로팅 버튼 설정
        addButton.setTitle("담기", for: .normal)
        addButton.backgroundColor = .systemGreen
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)
        
        closeButton.setTitle("X", for: .normal)
        closeButton.backgroundColor = .systemGray
        closeButton.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.width.equalTo(view.snp.width).multipliedBy(0.2)
            $0.height.equalTo(50)
        }
        
        addButton.snp.makeConstraints {
            $0.leading.equalTo(closeButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalTo(50)
        }
    }

    private func displayBookInfo() {
        guard let book = book else { return }
        titleLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: ", ")
        priceLabel.text = book.price.map { "\($0)원" } ?? "가격 정보 없음"
        contentsLabel.text = book.contents ?? "No description available."
        if let url = URL(string: book.thumbnail) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.thumbnailImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }

    @objc private func addButtonTapped() {
        guard let book = book else { return }
        delegate?.didAddBook(book) // Delegate를 통해 MainViewController로 책 정보를 전달
        dismiss(animated: true, completion: nil)
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
