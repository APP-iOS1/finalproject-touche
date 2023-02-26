//
//  ColorPaletteUnderView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/31.
//

import SwiftUI

struct ColorPaletteUnderView: View {
    var selectedColor: Color
    var perfumesCount: Int
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [selectedColor.opacity(0.3), Color.white]),
                                   startPoint: .bottom, endPoint: .top)
                )
        }
    }
}

//struct ColorPaletteUnderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorPaletteUnderView(selectedColor: .constant(.clear), perfumesCount: 0)
////            .environmentObject(ColorPalette())
//    }
//}
