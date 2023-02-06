//
//  ColorPaletteUnderView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/31.
//

import SwiftUI

struct ColorPaletteUnderView: View {
    @ObservedObject var colorPaletteCondition: ColorPalette
    var perfumesCount: Int
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [colorPaletteCondition.selectedColor.opacity(0.3), Color.white]),
                                   startPoint: .bottom, endPoint: .top)
                )

                // 동그라미 선택시 colorPaletteUnder의 선택된 동그라미가 커지는 효과
//                .frame(width: 300.0, height: 300.0)
//                .scaleEffect(colorPaletteCondition.selectedColor == colorPaletteCondition.selectedCircle ? 50 + CGFloat(perfumesCount / 2 * 25) : 1)
        }
//        .padding(7)
//        .padding(.horizontal)
    }
}

struct ColorPaletteUnderView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPaletteUnderView(colorPaletteCondition: ColorPalette(), perfumesCount: 0)
//            .environmentObject(ColorPalette())
    }
}
