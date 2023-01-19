//
//  WriteCommentView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI

struct WriteCommentView: View {
    @State private var reviewText: String = ""
    @Binding var perfume: Perfume
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: perfume.heroImage)) { image in
                    image
                        .resizable()
                        .frame(width:100, height: 100)
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading) {
                    Text(perfume.displayName)
                        
                    Text(perfume.brandName)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding()
            
            TextField("review", text: $reviewText, axis: .vertical)
//                .frame(height: 300)
                .textFieldStyle(.roundedBorder)
                .padding(15)
        }
        
        
        
        
    }
}

//struct WriteCommentView_Previews: PreviewProvider {
//    static var previews: some View {
        //        WriteCommentView(perfume: .constant(Perfume(perfumeId: "P258612",
        //                                                    brandName: "CHANEL",
        //                                                    displayName: "CHANCE EAU TENDRE Eau de Toilette",
        //                                                    heroImage: "https://www.sephora.com/productimages/sku/s2238145-main-grid.jpg",
        //                                                    fragranceFamily: "Fresh",
        //                                                    scentType: "Fresh Fruity Florals",
        //                                                    keyNotes: ["Citron", "Jasmine", "Teakwood"],
        //                                                    fragranceDescription: "The delicate and unexpected fruity-floral fragrance for women creates a soft whirlwind of happiness, fantasy, and radiance.")))
//    }
//}
