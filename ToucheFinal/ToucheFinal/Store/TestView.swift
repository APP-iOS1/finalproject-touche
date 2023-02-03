//
//  TestView.swift
//  ToucheFinal
//
//  Created by 김태성 on 2023/01/20.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var perfumeStore: PerfumeStore
    
    var body: some View {
        VStack {
                ForEach(perfumeStore.recentlyViewed7Perfumes, id: \.self) { perfume in
                    Button {
                    } label: {
                        VStack {
                            Text(perfume.displayName)
                            Text(perfume.perfumeId)
                        }.background(Color.mint)
                            .padding()
                    }
                }
            
        }
        .onAppear {
            perfumeStore.readViewedPerfumeIdsArrayAtUserInfo()
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
//                print(perfumeStore.recentlyViewedPerfumeIds)
//                perfumeStore.readRecentlyViewd7Perfumesss(recentlyViewedPerfumeIds: perfumeStore.recentlyViewedPerfumeIds)
//            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
