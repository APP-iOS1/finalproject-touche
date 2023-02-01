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
    @State private var shouldAnimate = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color(UIColor.systemGray5))
            .frame(width: 130, height: 130)
            .overlay(
                ZStack {
                    WebImage(url: URL(string: perfume.heroImage))
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                    CircleAnimation()
                        .offset(x: 40, y: -40)
                }
            )
    }
}

struct CircleAnimation: View {
    @State private var shouldAnimate = false
    
    var body: some View {
        Circle()
            .fill(PerfumeColor.types[13].color)
            .frame(width: 30, height: 30)
            .overlay(
                ZStack {
                    Circle()
                        .stroke(PerfumeColor.types[13].color, lineWidth: 100)
                        .scaleEffect(shouldAnimate ? 0.7 : 0)
                }
                .opacity(shouldAnimate ? 0.0 : 0.2)
                .animation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: false))
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
