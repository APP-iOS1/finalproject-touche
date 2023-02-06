//
//  PalletteCell.swift
//  ToucheFinal
//
//  Created by 김태성 on 2023/01/30.
//

import SwiftUI

struct PalletteCell: View {
    var color: Color
    var degrees: Double
    var name: String
    var count: Double
    var opacity: Double {

        switch count {
        case 0:
            return 0.2
        case 1:
            return 0.4
        case 2:
            return 0.6
        default:
            return 1
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Circle()
                    .trim(from: 0.7205, to: 0.7795)
                    .stroke(lineWidth: 50)
                    .overlay{
                        Text(name)
                            .font(.system(size: 14))
                            .minimumScaleFactor(0.99)
                            .lineLimit(2)
                            .frame(width: 55)
                            .offset(x: 0, y: -geometry.size.height / 2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .rotationEffect(Angle(degrees: degrees))
                    .foregroundColor(color)
            }
        }
        .frame(width: 300, height: 300)
    }
}

struct PalletteCell_Previews: PreviewProvider {
    static var previews: some View {
        PalletteCell(color: .red, degrees: 40, name: "Fresh Aquatics", count: 3)
    }
}
