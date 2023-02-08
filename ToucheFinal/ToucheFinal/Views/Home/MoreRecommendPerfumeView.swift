//
//  MoreRecommendPerfumeView.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/02/08.
//

import SwiftUI

struct MoreRecommendPerfumeView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @EnvironmentObject var perfumeStore: PerfumeStore
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(perfumeStore.recomendedPerfumes.prefix(10), id: \.self.perfumeId) { perfume in
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
