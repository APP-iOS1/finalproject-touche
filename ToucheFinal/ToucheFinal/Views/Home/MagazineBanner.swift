//
//  MagazineBanner.swift
//  ToucheFinal
//
//  Created by TAEHYOUNG KIM on 2023/02/14.
//

import SwiftUI

struct MagazineBanner: View {
//    var animation: Namespace.ID
//    @Environment(\.colorScheme) var color
    var magazine: Magazine
    var body: some View {
        VStack(alignment: .leading ,spacing: 0) {
            Spacer()
            VStack(alignment: .leading, spacing: 4) {
                Text(magazine.title)
                    .font(.title).bold()
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(
                Color.black
            )
        }
        .frame(maxWidth: .infinity, minHeight: 400)
        .background(
            
            CacheAsyncImage(url: URL(string: magazine.contentImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                
            }
        )
        .clipShape(Rectangle())
//        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
//        .padding(20)

    }
}

struct MagazineBanner_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        MagazineBanner(magazine: magazines[0])
    }
}
