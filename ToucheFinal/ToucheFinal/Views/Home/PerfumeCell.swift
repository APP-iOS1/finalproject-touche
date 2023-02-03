//
//  PerfumeCell.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/18.
//

import SwiftUI
import SDWebImageSwiftUI

//struct PerfumeCell: View {
//    var perfume: Perfume
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            WebImage(url: URL(string: perfume.heroImage))
//                .resizable()
//                .frame(width: 130, height: 130)
//            Text(perfume.brandName)
//                .unredacted()
////                .fontWeight(.medium)
//                .foregroundColor(.black)
//                .frame(width: 130, alignment: .leading)
//                .lineLimit(1)
//
//            Text(perfume.displayName)
//                .font(.system(size: 14))
//                .foregroundColor(.black)
//                .frame(width: 130, alignment: .leading)
//                .lineLimit(1)
//
//            HStack{
//                Image(systemName: perfume.likedPeople.contains("userId") ? "heart.fill" : "heart")
//                    .resizable()
//                    .frame(width: 13, height: 12)
//                    .padding(.trailing, -5)
//                Text("\(perfume.likedPeople.count)")
//                    .font(.system(size: 14))
//                Image(systemName: "message")
//                    .resizable()
//                    .frame(width: 13, height: 13)
//                    .padding(.trailing, -5)
//                Text("\(perfume.commentCount)" )
//                    .font(.system(size: 14))
//            }
//            .foregroundColor(.black)
//            .padding(.top, -7)
//            .padding(.leading, 2)
//        }
//    }
//}

struct PerfumeCell: View {
    let perfume: Perfume
    var frameWidth: CGFloat = 130
    @State private var shouldAnimate: Bool = false
//    @Binding var show: Bool
//    var animation: Namespace.ID
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            WebImage(url: URL(string: perfume.heroImage))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: frameWidth)
                .padding(.top, 20)
//                .matchedGeometryEffect(id: "image", in: animation)
            VStack(alignment: .leading) {
                Text(perfume.brandName)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text(perfume.displayName)
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
            HStack(alignment: .center, spacing: 10) {
                HStack(spacing: 3) {
                    Image(systemName: perfume.likedPeople.contains("userId") ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 13, height: 12)
                    Text("\(perfume.likedPeople.count)")
                        .font(.system(size: 14))
                }
                HStack(spacing: 3) {                    Image(systemName: "message")
                        .resizable()
                        .frame(width: 13, height: 13)
                    Text("\(perfume.commentCount)" )
                        .font(.system(size: 14))
                }
            }
            .foregroundColor(.secondary)
        }
        .frame(width: frameWidth)
        .padding(10.0)
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .circular))
        .background(
            RoundedRectangle(cornerRadius: 10.0, style: .circular)
                .fill(Color.white)
                .shadow(radius: 3, x: 1, y: 1)
            )
        .overlay(alignment: .topTrailing, content: {
            let color = Color(hex: setHexValue(scentType: perfume.scentType)) ?? .primary
            Circle()
                .fill(color.gradient)
                .frame(width: 15, height: 15, alignment: .center)
                .scaleEffect(shouldAnimate ? 1.2 : 1)
                .padding([.top, .trailing], 8.0)
                .shadow(
                    color: shouldAnimate ? color : color.opacity(0.1),
                    radius: shouldAnimate ? 3 : 1.5,
                    x: 0,
                    y: 0
                )
                .animation(.linear(duration: 2).delay(.random(in: 0.0..<1.0)).repeatForever(autoreverses: true), value: shouldAnimate)
        })
        .onAppear {
            shouldAnimate = true
        }
        .onDisappear {
            shouldAnimate = false
        }
//        .onTapGesture {
//            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
//                show.toggle()
//            }
//        }
    }
}



struct PerfumeCell_Previews: PreviewProvider {
    @Namespace static var animation
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
                                    )
        )
    }
}
