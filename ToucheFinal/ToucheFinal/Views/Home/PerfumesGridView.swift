//
//  SeeMoreView.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/20.
//

import SwiftUI

struct PerfumesGridView: View {
    var perfumes: [Perfume]
    var title: String
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())]
    var body: some View {
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
        .navigationBarTitle(title)
    }
}
struct PerfumesGridView_Previews: PreviewProvider {
    static var previews: some View {
        PerfumesGridView(perfumes: dummy, title: "7")
    }
}
