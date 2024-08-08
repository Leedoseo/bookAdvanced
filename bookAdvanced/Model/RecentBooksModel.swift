//
//  RecentBooksViewModel.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/8/24.
//

import Foundation

class RecentBooksModel {
    private(set) var recentBooks: [Book] = [] {
        didSet {
            onBooksUpdated?()
        }
    }
    
    var onBooksUpdated: (() -> Void)?
    
    func addRecentBook(_ book: Book) {
        recentBooks.removeAll { $0.title == book.title }
        recentBooks.insert(book, at: 0)
        
        if recentBooks.count > 10 {
            recentBooks.removeLast()
        }
    }
}

