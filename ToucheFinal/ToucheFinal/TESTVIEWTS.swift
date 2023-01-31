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
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 15) {
//                Wheel(radius: radius, rotation: angle, pointToCenter: false) {
//                    contents()
//                }
                
//                Wheel(radius: radius, rotation: angle, pointToCenter: true) {
//                    contents()
//                }
                ZStack {
                    ForEach(Array(PerfumeColor.types.enumerated()), id: \.offset) { index, color in
                        RoundedRectangle(cornerRadius: 30)
                            .fill(color.color.opacity(0.7))
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
  
                                Circle()
                                            // .fill(Color.blue)
                                            // .foregroundColor(.pink)
                                            // .stroke(Color.red, lineWidth: 20)
                                            // .stroke(Color.orange, style: StrokeStyle(lineWidth: 30, lineCap: .butt, dash: [30] ))
                                                .trim(from: 0.7, to: 0.8)
                                                .stroke(Color.cyan, lineWidth: 50)
                                                .frame(width: 500, height: 150)
                                                .padding()
                                //                .rotationEffect(Angle(degrees: -70))
//                                RoundedRectangle(cornerRadius: 30)
//                                    .fill(color.color.opacity(0.7))
//                                //                                        .grayscale(1.0)
//                                //                                        .saturation(0.0)
//                                    .frame(width: 70, height: 70)
//                                    .overlay {
//                                        Text("\(String(color.name.prefix(13)))")
//                                            .font(.system(size: 12))
//                                            .foregroundColor(.white)
//                                    }
                            }
                            .opacity(isTapped ? color.name == txt ? 0 : 1 : 1)
                            .onTapGesture {
                                txt = color.name
                                print(color.name)
                                isTapped = true
                            }
//                            Button {
//                                txt = color.name
//                                print(color.name)
//                                isTapped = true
//                            } label: {
//                                WheelComponent(animation: animation) {
//
//                                    RoundedRectangle(cornerRadius: 30)
//                                    //                                        .offset(x:isTapped ? color.name == txt ? -40 : 0 : 0, y: isTapped ? color.name == txt ? -40 : 0 : 0)
//                                        .fill(color.color.opacity(0.7))
//                                    //                                        .grayscale(1.0)
//                                    //                                        .saturation(0.0)
//                                        .frame(width: 70, height: 70)
//                                        .overlay {
//                                            Text("\(String(color.name.prefix(13)))")
//                                                .font(.system(size: 12))
//                                                .foregroundColor(.white)
//                                            //                                                .offset(x:isTapped ? color.name == txt ? -40 : 0 : 0, y: isTapped ? color.name == txt ? -40 : 0 : 0)
//                                        }
//                                }
//                                .opacity(isTapped ? color.name == txt ? 0 : 1 : 1)
//                            }
                        }
                    } // wheel 끝
                }
            }
            .onAppear {
                // Set the view rotation animation after the view appeared,
                // to avoid animating initial rotation
//                DispatchQueue.main.async {
//                    animation = .easeInOut(duration: 1.0)
//                }
//                withAnimation(.linear(duration: 60.0).repeatForever()) {
//                    angle = (angle == .zero ? .degrees(360) : .zero)
//                }
            }
            
            Spacer()
            
//            Button("Rotate") {
//                withAnimation(.easeInOut(duration: 4.0).repeatForever()) {
//                    angle = (angle == .zero ? .degrees(360) : .zero)
//                }
//            }
            
            HStack {
                Text("\(txt)")
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
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
