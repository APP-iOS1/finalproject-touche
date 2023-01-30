//
//  WishListPerfumeCell.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct WishListPerfumeCell: View {
    
    var perfume: Perfume
    
    var body: some View {
        VStack(alignment: .leading) {
            WebImage(url: URL(string: perfume.heroImage))
                .resizable()
                .frame(width: 130, height: 130)
            Text(perfume.brandName)
                .unredacted()
//                .fontWeight(.semibold)
                .foregroundColor(.black)
                .frame(width: 130, alignment: .leading)
                .lineLimit(1)
            
            Text(perfume.displayName)
                .font(.system(size: 14))
                .foregroundColor(.black)
                .frame(width: 130, alignment: .leading)
                .lineLimit(1)
            
            HStack{
                Text("\(Image(systemName: "heart"))\(perfume.likedPeople.count)")
                Text("\(Image(systemName: "message")) \(perfume.commentCount)" )
            }.foregroundColor(.black)
        }
    }
}

//struct WishListPerfumeCell_Previews: PreviewProvider {
//    static var previews: some View {
//        WishListCellPerfume()
//    }
//}
