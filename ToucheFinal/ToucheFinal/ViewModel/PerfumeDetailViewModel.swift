//
//  PerfumeDetailView.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/02/03.
//

import SwiftUI
import FirebaseFirestore

class PerfumeDetailViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    let perfumeStore = PerfumeStore.shared
    
    
    
}
