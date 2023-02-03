//
//  ColorPalette.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/02/01.
//

import SwiftUI

class ColorPalette: ObservableObject {
    // 선택된 색 동그라미 확인, SelectedColor의 var circleColorTitle과 연계하는 경우 있음
    @Published var selectedCircle: Color = .clear
    // 색 전환을 위한 기본 색 지정
    @Published var selectedColor: Color = .clear
}
