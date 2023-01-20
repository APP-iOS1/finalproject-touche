//
//  SeeMoreView.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/20.
//

import SwiftUI

struct PerfumesGridView: View {
    var perfumes: [Perfume]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())]
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                HStack{
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(dummy, id: \.self.perfumeId) { perfume in
                                NavigationLink {
                                    PerfumeDetailView(perfume: perfume)
                                } label: {
                                    PerfumeCell(perfume: perfume)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
struct PerfumesGridView_Previews: PreviewProvider {
    static var previews: some View {
        PerfumesGridView(perfumes: dummy)
    }
}
