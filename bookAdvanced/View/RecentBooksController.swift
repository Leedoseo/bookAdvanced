//
//  RecentBooksViewController.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/8/24.
//

import UIKit
import SnapKit

class RecentBooksController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var collectionView: UICollectionView!
    private let viewModel = RecentBooksModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        let recentLayout = UICollectionViewFlowLayout()
        recentLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: recentLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "recentBookCell")
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        viewModel.onBooksUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func updateWithBook(_ book: Book) {
        viewModel.addRecentBook(book)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recentBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentBookCell", for: indexPath) as! BookCollectionViewCell
        let book = viewModel.recentBooks[indexPath.item]
        cell.configure(with: book, forRecentBooks: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}

