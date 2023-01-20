//
//  SeeMoreView.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/20.
//

import SwiftUI

struct SeeMoreView: View {
    var title: String
    var perfumes: [Perfume]
    var body: some View {
        NavigationStack {
            VStack{
                PerfumesGridView(perfumes: perfumes)
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SeeMoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SeeMoreView(title: "aa", perfumes: dummy)
        }
    }
}
