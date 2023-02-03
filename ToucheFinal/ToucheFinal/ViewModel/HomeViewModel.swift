//
//  HomeViewModel.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/02/03.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var recomendedPerfume: [Perfume] = []
    @Published var recentlyViewed7Perfumes: [Perfume] = []
    let perfumeStore = PerfumeStore.shared
    
    func filterRecommendedPerfumes(selectedScentTypes: [String]) {
        recomendedPerfume = Array(Set(perfumeStore.perfumes.filter{selectedScentTypes.contains($0.scentType)}))
    }
    
    func filterRecentlyViewed7Perfumes(perfumesId: [String]) {
        var perfumes: [Perfume] = []
        
        for id in perfumesId {
            perfumes += perfumeStore.perfumes.filter{ $0.perfumeId == id }
        }
        recentlyViewed7Perfumes = perfumes
    }
}
