//
//  MagazineBanner.swift
//  ToucheFinal
//
//  Created by TAEHYOUNG KIM on 2023/02/14.
//

import SwiftUI

struct MagazineBanner: View {
    var magazine: Magazine
    var body: some View {
        VStack() {
            Spacer()
            Text(magazine.title)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(Color.black)
                
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
    }
}

//struct MagazineBanner_Previews: PreviewProvider {
//    static var previews: some View {
//        MagazineBanner(magazine: dummyWithOtherProjectFirebaseStorage[0])
//    }
//}
