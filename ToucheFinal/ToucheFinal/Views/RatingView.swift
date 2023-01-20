//
//  RatingView.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/18.
//

import SwiftUI

struct RatingView: View {
    @Binding var score: Int
    var frame: Int
    var canClick: Bool
    
    var body: some View {
        HStack{
            ForEach(1..<6) { rating in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: CGFloat(frame), height: CGFloat(frame))
                    .foregroundColor( score >= rating ? .red : .gray)
                    .onTapGesture {
                        if canClick{
                            score = rating
                        }
                    }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(score: .constant(3), frame: 15, canClick: true)
    }
}
