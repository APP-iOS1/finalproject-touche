//
//  MoreRecommendPerfumeView.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/02/08.
//

import SwiftUI

// 더보기 최대 32개 보이게 설정
// 현재 선택한 타입에 따라 랜덤하게 32개 보여줌. (각 타입마다 보여지는 개수 정해지지 않음. 데이터가 안들어가있는 타입도 존재)

struct MoreRecommendPerfumeView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @EnvironmentObject var perfumeStore: PerfumeStore
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(perfumeStore.recomendedPerfumes.prefix(32), id: \.self.perfumeId) { perfume in
                        NavigationLink {
                            PerfumeDetailView(perfume: perfume)
                        } label: {
                            PerfumeCell(perfume: perfume)
                        }
                        
                    }
                }
                .padding()
            }
            .navigationTitle("RECOMMENDATION PERFUME FOR YOU")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .foregroundColor(.black)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MoreRecommendPerfumeView_Previews: PreviewProvider {
    static var previews: some View {
        MoreRecommendPerfumeView()
            .environmentObject(PerfumeStore())
    }
}
