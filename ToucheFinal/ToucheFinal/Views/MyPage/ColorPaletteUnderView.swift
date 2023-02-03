//
//  ColorPaletteUnderView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/31.
//

import SwiftUI

struct ColorPaletteUnderView: View {
    @EnvironmentObject var colorPaletteCondition: ColorPalette
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [colorPaletteCondition.selectedColor, Color.white]),
                                   startPoint: .bottom, endPoint: .top)
                )

                // 동그라미 선택시 colorPaletteUnder의 선택된 동그라미가 커지는 효과
                .frame(width: 30.0, height: 30.0)
                .scaleEffect(colorPaletteCondition.selectedColor == colorPaletteCondition.selectedCircle ? 80 : 1)
        }
        .padding(7)
        .padding(.horizontal)
    }
}

struct ColorPaletteUnderView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPaletteUnderView()
            .environmentObject(ColorPalette())
    }
}
