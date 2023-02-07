//
//  SearchQuery.swift
//  ToucheFinal
//
//  Created by james seo on 2023/02/07.
//

import Foundation

struct SearchQuery: Identifiable, Equatable {
    let id = UUID().uuidString
    let category: Category
    let query: String
    
    enum Category: String {
        case brand
        case perfume
    }
}
