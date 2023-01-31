//
//  TESTVIEWTS.swift
//  ToucheFinal
//
//  Created by 김태성 on 2023/01/31.
//

import SwiftUI

import SwiftUI

struct TESTVIEWTS: View {
    @State private var angle: Angle = .zero
    @State private var radius: CGFloat = 140.0
    @State private var animation: Animation? = nil
    @State private var txt = ""
    @State private var isTapped = false
    @State private var scentTypeCount: [String: Int] = [:]
    
    var body: some View {
        ScrollView {
            Text("My Perfume Palette")
                .font(.largeTitle)
                .padding(.bottom, 40)
                .fontWeight(.semibold)
            
            ZStack {
                
                // 과녁판 테두리 색
                ForEach(Array(PerfumeColor.types.enumerated()), id: \.offset) { index, color in
                    PalletteCell(color: color.color, degrees: Double(index) * 22.5, name: color.name, count: scentTypeCount[color.name] ?? 1)
                        .rotationEffect(Angle(degrees: -79))
                }
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .frame(width: 250, height: 250)
                )

                // 가운데 있는 색
                ForEach(Array(PerfumeColor.types.enumerated()), id: \.offset) { index, color in
                    RoundedRectangle(cornerRadius: 30)
                        .fill(color.color)
                        .frame(width: 70, height: 70)
                        .overlay {
                            Text("\(String(color.name.prefix(13)))")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                        .opacity(isTapped ? color.name == txt ? 1 : 0 : 0)
                        .animation(.linear(duration: 0.5))
                }
                
                Wheel(radius: radius, rotation: angle, pointToCenter: true) {
                    //                    contents(animation: animation)
                    ForEach(Array(PerfumeColor.types.enumerated()), id: \.offset) { index, color in
                        WheelComponent(animation: animation) {
                            RoundedRectangle(cornerRadius: 0)
                                .fill(color.color.opacity(0))
                            //                                        .grayscale(1.0)
                            //                                        .saturation(0.0)
                                .frame(width: 70, height: 70)
                                .overlay {
                                    Text("\(String(color.name.prefix(15)))")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                        .padding(.bottom, 30)
                                        .padding(.horizontal, 6)
                                }
                        }
                        .opacity(isTapped ? color.name == txt ? 0 : 1 : 1)
                        .onTapGesture {
                            txt = color.name
                            print(color.name)
                            isTapped = true
                        }
                        
                    }
                } // wheel 끝
            }
            
            HStack {
                Text("Scent Type")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.top, 30)
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851))
                .overlay (
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus bibendum nulla libero, vel accumsan sapien blandit ac. Donec nunc ligula, imperdiet eu massa ac, vehicula faucibus neque.")
                        .padding()
                )
                .frame(height: 200)

            HStack {
                Text("Wish List")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.top, 30)
            
        }
        .padding()
        .onAppear {
            
            //                withAnimation(.linear(duration: 60.0).repeatForever()) {
            //                    angle = (angle == .zero ? .degrees(360) : .zero)
            //                }
            for perfume in dummy {
                scentTypeCount[perfume.scentType] = (scentTypeCount[perfume.scentType] ?? 0) + 1
            }
        }
    }
    
//    @ViewBuilder func contents(animation: Animation? = nil) -> some View {
//        ForEach(Array(PerfumeColor.types.enumerated()), id: \.offset) { index, color in
//            Button {
//                print(color.name)
//            } label: {
//                WheelComponent(animation: animation) {
//                    RoundedRectangle(cornerRadius: 30)
//                        .fill(color.color.opacity(0.7))
//                        .frame(width: 70, height: 70)
//                        .overlay {
//                            Text("\(String(color.name.prefix(13)))")
//                                .font(.system(size: 12))
//                                .foregroundColor(.white)
//                        }
//
//                }
//            }
//        }
//    }
}

struct Rotation: LayoutValueKey {
    static let defaultValue: Binding<Angle>? = nil
}

struct WheelComponent<V: View>: View {
    var animation: Animation? = nil
    @ViewBuilder let content: () -> V
    @State private var rotation: Angle = .zero

    var body: some View {
        content()
            .rotationEffect(rotation)
            .layoutValue(key: Rotation.self, value: $rotation.animation(animation))
    }
}

struct Wheel: Layout {
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(rotation.radians, radius)
        }
        set {
            rotation = Angle.radians(newValue.first)
            radius = newValue.second
        }
    }
    
    var radius: CGFloat
    var rotation: Angle
    var pointToCenter = false
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        
        let maxSize = subviews.map { $0.sizeThatFits(proposal) }.reduce(CGSize.zero) {
            
            return CGSize(width: max($0.width, $1.width), height: max($0.height, $1.height))
            
        }
        
        return CGSize(width: (maxSize.width / 2 + radius) * 2,
                      height: (maxSize.height / 2 + radius) * 2)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let angleStep = (Angle.degrees(360).radians / Double(subviews.count))

        for (index, subview) in subviews.enumerated() {
            let angle = angleStep * CGFloat(index) + rotation.radians
            
            // Find a vector with an appropriate size and rotation.
            var point = CGPoint(x: 0, y: -radius).applying(CGAffineTransform(rotationAngle: angle))
            
            // Shift the vector to the middle of the region.
            point.x += bounds.midX
            point.y += bounds.midY
            
            // Place the subview.
            subview.place(at: point, anchor: .center, proposal: .unspecified)
            
            DispatchQueue.main.async {
                if pointToCenter {
                    subview[Rotation.self]?.wrappedValue = .radians(angle)
                } else {
                    subview[Rotation.self]?.wrappedValue = .zero
                }
            }
        }
    }
}


struct TESTVIEWTS_Previews: PreviewProvider {
    static var previews: some View {
        TESTVIEWTS()
    }
}
