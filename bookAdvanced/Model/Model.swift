//
//  Model.swift
//  bookAdvanced
//
//  Created by t2023-m0112 on 8/1/24.
//

import Foundation

struct Book: Codable {
    let title: String
    let authors: [String]
    let contents: String?  // Optional로 변경
    let thumbnail: String
    let price: Int?
}

struct BookResponse: Codable {
    let documents: [Book]
}

