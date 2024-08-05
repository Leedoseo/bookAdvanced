//
//  SearchViewModel.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/1/24.
//

import Foundation

class SearchViewModel {
    private var books: [Book] = []
    
    var onBooksUpdated: (() -> Void)?
    
    func searchBooks(query: String) {
        guard let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "KakaoAK 223d3a17c9ddc64ab697d5eda7a14707"]

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(BookResponse.self, from: data)
                    self.books = decodedResponse.documents
                    DispatchQueue.main.async {
                        self.onBooksUpdated?()
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
    func getBooks() -> [Book] {
        return books
    }
}
