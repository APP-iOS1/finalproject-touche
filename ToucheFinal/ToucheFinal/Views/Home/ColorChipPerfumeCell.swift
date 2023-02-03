//
//  ColorChipPerfumeCell.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/01/31.
//

import SwiftUI
import SDWebImageSwiftUI

struct ColorChipPerfumeCell: View {
    var perfume: Perfume
//    @State private var shouldAnimate = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color.white)
                .frame(width: 200.0, height: 200.0)
                .padding(2.0)
                .shadow(
                    color: Color(hex: setHexValue(scentType: perfume.scentType))?
                        .opacity(0.2) ?? .primary.opacity(0.2),
                    radius: 4,
                    x: 2,
                    y: 2
                )
            
            WebImage(url: URL(string: perfume.heroImage))
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 180)
        }
    }
}

struct CircleAnimation: View {
    @State private var shouldAnimate = false
    var perfume: Perfume
    var body: some View {
        Circle()
            .fill(Color(hex: setHexValue(scentType: perfume.scentType)) ?? Color.white)
            .frame(width: 30, height: 30)
            .overlay(
                ZStack {
                    Circle()
                        .stroke(Color(hex: setHexValue(scentType: perfume.scentType)) ?? Color.white, lineWidth: 100)
                        .scaleEffect(shouldAnimate ? 0.7 : 0)
                }
                .opacity(shouldAnimate ? 0.0 : 0.2)
                .animation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: false), value: shouldAnimate)
        )
        .onAppear {
            self.shouldAnimate = true
        }
    }
    
}


struct ColorChipPerfumeCell_Previews: PreviewProvider {
    static var previews: some View {
        ColorChipPerfumeCell(perfume: Perfume(perfumeId: "P449116",
                                              brandName: "Valentino",
                                              displayName: "Donna Born In Roma Eau de Parfum",
                                              heroImage: "https://www.sephora.com/productimages/sku/s2249688-main-grid.jpg",
                                              image450: "https://www.sephora.com/productimages/sku/s2249688-main-grid.jpg",
                                              fragranceFamily: "Floral",
                                              scentType: "Warm Florals",
                                              keyNotes: ["Blackcurrant", "Jasmine Grandiflorum", "Bourbon Vanilla"],
                                              fragranceDescription: "A floral fragrance inspired by Roman street style.",
                                              likedPeople: ["1", "2", "3"],
                                              commentCount: 3154,
                                              totalPerfumeScore: 15770
                                             ))
    }
}
