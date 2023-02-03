//
//  PerfumeCell.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/18.
//

import SwiftUI
import SDWebImageSwiftUI

struct PerfumeCell: View {
    var perfume: Perfume
    
    var body: some View {
        VStack(alignment: .leading) {
            WebImage(url: URL(string: perfume.heroImage))
                .resizable()
                .frame(width: 130, height: 130)
            Text(perfume.brandName)
                .unredacted()
//                .fontWeight(.medium)
                .foregroundColor(.black)
                .frame(width: 130, alignment: .leading)
                .lineLimit(1)
            
            Text(perfume.displayName)
                .font(.system(size: 14))
                .foregroundColor(.black)
                .frame(width: 130, alignment: .leading)
                .lineLimit(1)
            
            HStack{
                Image(systemName: perfume.likedPeople.contains("userId") ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 13, height: 12)
                    .padding(.trailing, -5)
                Text("\(perfume.likedPeople.count)")
                    .font(.system(size: 14))
                Image(systemName: "message")
                    .resizable()
                    .frame(width: 13, height: 13)
                    .padding(.trailing, -5)
                Text("\(perfume.commentCount)" )
                    .font(.system(size: 14))
            }
            .foregroundColor(.black)
            .padding(.top, -7)
            .padding(.leading, 2)
        }
    }
}

struct PerfumeCell_Previews: PreviewProvider {
    static var previews: some View {
        PerfumeCell(perfume: Perfume(perfumeId: "P258612",
                                     brandName: "CHANEL",
                                     displayName: "CHANCE EAU TENDRE Eau de Toilette",
                                     heroImage: "https://www.sephora.com/productimages/sku/s2238145-main-grid.jpg",
                                     image450: "https://www.sephora.com/productimages/sku/s2238145-main-grid.jpg",
                                     fragranceFamily: "Fresh",
                                     scentType: "Fresh Fruity Florals",
                                     keyNotes: ["Citron", "Jasmine", "Teakwood"],
                                     fragranceDescription: "The delicate and unexpected fruity-floral fragrance for women creates a soft whirlwind of happiness, fantasy, and radiance.",
                                     likedPeople: ["1", "2"],
                                     commentCount: 154,
                                     totalPerfumeScore: 616
                                    ))
    }
}
