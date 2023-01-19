//
//  RatingView.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/18.
//

import SwiftUI

struct RatingView: View {
    @Binding var score: Int
    var body: some View {
        HStack{
            ForEach(0..<5) { rating in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor( score > rating ? .red : .gray)
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(score: .constant(3))
    }
}
