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
        VStack {
            NavigationLink {
                //                DetailView(perfume: perfume)
            } label: {
                VStack(alignment: .leading) {
                    WebImage(url: URL(string: perfume.heroImage))
                    
                    Text(perfume.brandName)
                        .unredacted()
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(width: 150, alignment: .leading)
                        .lineLimit(1)
                    
                    Text(perfume.displayName)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .frame(width: 150, alignment: .leading)
                        .lineLimit(1)
                    
                    HStack{
                        Text("\(Image(systemName: "heart"))\(perfume.likedPeople.count)")
                        Text("\(Image(systemName: "message")) \(perfume.commentCount)" )
                    }.foregroundColor(.black)
                }
            }
        }
    }
}
                             

struct PerfumeCell_Previews: PreviewProvider {
    static var previews: some View {
        PerfumeCell(perfume: Perfume(id: "P258612",
                                     brandName: "CHANEL",
                                     displayName: "CHANCE EAU TENDRE Eau de Toilette",
                                     heroImage: "https://www.sephora.com/productimages/sku/s2238145-main-grid.jpg",
                                     fragranceFamily: "Fresh",
                                     scentType: "Fresh Fruity Florals",
                                     keyNotes: ["Citron", "Jasmine", "Teakwood"],
                                     fragranceDescription: "The delicate and unexpected fruity-floral fragrance for women creates a soft whirlwind of happiness, fantasy, and radiance.",
                                     likedPeople: ["1", "2"],
                                     commentCount: 5,
                                     totalPerfumeScore: 8
                                    ))
        
    }
}
