//
//  ColorPalette.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/02/01.
//

import SwiftUI

class ColorPalette: ObservableObject {
    // 색 전환을 위한 기본 색 지정
    @Published var selectedColor: Color = .clear
}
