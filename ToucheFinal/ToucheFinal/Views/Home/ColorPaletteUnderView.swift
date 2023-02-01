//
//  ColorPaletteUnderView.swift
//  Touche
//
//  Created by 전근섭 on 2022/11/08.
//

import SwiftUI


struct ColorPaletteUnderView: View {
    @EnvironmentObject var colorPaletteCondition: ColorPalette
//    let parfumJson: Parfum
    
    @State private var colors: [Color] = [.red, .yellow, .blue, .green, .blue, .purple, .gray]
    
    var body: some View {
        
        HStack {
            ForEach(colors, id: \.self) { color in
                Button {
                    colorPaletteCondition.selectedCircle = "\(color)" // 선택된 동그라미의 enum 값을 String로 변환
                    
                } label: {
                    Circle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [color, Color.white]),
                                           startPoint: .bottom, endPoint: .top)
                        )
                    
                        // 동그라미 선택시 colorPaletteUnder의 선택된 동그라미가 커지는 효과
                        .frame(width: 30.0, height: 30.0)
                        .scaleEffect("\(color)" == colorPaletteCondition.selectedCircle ? 40 : 1)
                          
                }
            }
        }
        .padding(7)
        .padding(.horizontal)
        
    }
    
//    func selectedCircleScaleEffect(color: SelectedColor) -> CGFloat {
//        switch color {
//        case .red: return 10
//        case .brown: return 10
//        case .yellow: return 10
//        case .green: return 10
//        case .blue: return 10
//        case .purple: return 10
//        case .gray: return 10
//        }
//    }
}
class ColorPalette: ObservableObject {
    @Published var colorPaletteTaped: Bool = false // colorPalette를 탭 했는지 확인
    @Published var colorPaletteUnderTaped: Bool = false // 색 전환 애니메이션용 colorPalette 탭 확인
    @Published var selectedCircle: String = "" // 선택된 색 동그라미 확인, SelectedColor의 var circleColorTitle과 연계하는 경우 있음
    @Published var selectedColor: Color = .black // 색 전환을 위한 기본 색 지정
    @Published var withOutToucheColor: String = "" // 색 이름에서 touche를 없앤 것
    
//    init(colorPaletteTaped: Bool, colorPaletteUnderTaped: Bool) {
//        self.colorPaletteTaped = colorPaletteTaped
//        self.colorPaletteUnderTaped = colorPaletteUnderTaped
//    }
}
struct ColorPaletteUnderView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPaletteUnderView()
            .environmentObject(ColorPalette())
    }
}
