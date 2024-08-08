//
//  BookCollectionViewCell.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/5/24.
//

import UIKit
import SnapKit

class BookCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let thumbnailImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaultUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDefaultUI() {
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.clipsToBounds = true
        contentView.addSubview(thumbnailImageView)

        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        contentView.addSubview(titleLabel)

        authorLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        authorLabel.numberOfLines = 1
        authorLabel.textAlignment = .left
        contentView.addSubview(authorLabel)

        thumbnailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(60)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }

        authorLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }

    private func setupRecentBooksUI() {
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.clipsToBounds = true
        contentView.addSubview(thumbnailImageView)

        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)

        authorLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        authorLabel.textAlignment = .center
        authorLabel.textColor = .gray
        contentView.addSubview(authorLabel)

        thumbnailImageView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(120)
        }

        titleLabel.snp.remakeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(5)
        }

        authorLabel.snp.remakeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().offset(-5)
        }
    }

    func configure(with book: Book, forRecentBooks: Bool = false) {
        titleLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: ", ")
        if let url = URL(string: book.thumbnail) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.thumbnailImageView.image = UIImage(data: data)
                    }
                }
            }
        }

        if forRecentBooks {
            setupRecentBooksUI() // 최근 본 책 UI 적용
        } else {
            setupDefaultUI() // 검색 결과 UI 적용
        }
    }
}
