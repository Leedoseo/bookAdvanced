//
//  CartBookCell.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/7/24.
//

import UIKit
import SnapKit

class CartBookCell: UICollectionViewCell {

    private let thumbnailImageView = UIImageView()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // 썸네일 이미지 설정
        thumbnailImageView.contentMode = .scaleAspectFit
        contentView.addSubview(thumbnailImageView)
        
        // 책 제목 설정
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(titleLabel)
        
        // 저자 설정
        authorLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentView.addSubview(authorLabel)
        
        // 가격 설정
        priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentView.addSubview(priceLabel)
        
        // 레이아웃 설정
        thumbnailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(60) // 썸네일 크기 설정
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        authorLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        priceLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            $0.top.equalTo(authorLabel.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }

    func configure(with book: Book) {
        titleLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: ", ")
        priceLabel.text = book.price.map { "\($0)원" } ?? "가격 정보 없음"
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
}

