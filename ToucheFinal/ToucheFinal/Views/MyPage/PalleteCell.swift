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
        case 3:
            return 1
        case 2:
            return 0.6
        case 1:
            return 0.4
        default:
            return 0.2
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                path.move(to: center)
                path.addArc(center: center, radius: 180, startAngle: Angle(degrees: degrees), endAngle: Angle(degrees: degrees - 22), clockwise: true)
                path.addLine(to: center)
            }
            .fill(color)
        }
        .opacity(opacity)
    }
}

struct PalletteCell_Previews: PreviewProvider {
    static var previews: some View {
        PalletteCell(color: .red, degrees: 40, name: "name", count: 3)
    }
}
