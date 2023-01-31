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
    var count: Int
    var grayOpacity: Double {
        Double(1 / count)
    }
    
    var body: some View {
        Path { path in
            let center = CGPoint(x: 50, y: 50)
            path.move(to: center)
            path.addArc(center: center, radius: 180, startAngle: Angle(degrees: degrees), endAngle: Angle(degrees: degrees - 22), clockwise: true)
            path.addLine(to: center)
        }
        .fill(color)
//        .grayscale(grayOpacity)
        .frame(width: 100, height: 100)
    }
}

struct PalletteCell_Previews: PreviewProvider {
    static var previews: some View {
        PalletteCell(color: .red, degrees: 40, name: "name", count: 3)
    }
}
