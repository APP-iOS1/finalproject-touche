//
//  PaletteViewModel.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/02/03.
//

import Foundation

class PaletteViewModel: ObservableObject {
    @Published var likedPerfumes: [Perfume] = []
    @Published var likedScentTypePerfumes: [Perfume] = []
    
    let perfumeStore = PerfumeStore.shared
    
    
    func filterLikedPerfumes(userId: String) {
        likedPerfumes = perfumeStore.perfumes.filter{ $0.likedPeople.contains(userId) }
    }
    
    func filterLikedScentTypePerfumes(scentType: String) {
        likedScentTypePerfumes = likedPerfumes.filter{ $0.scentType == scentType }
    }
    
}
