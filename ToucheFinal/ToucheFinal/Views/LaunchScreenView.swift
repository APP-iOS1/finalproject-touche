//
//  LaunchScreenView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/15.
//

import SwiftUI

struct LaunchScreenView: View {
    //    @State private var isActive = false
    //    @Binding var isShowingOnboardingView: Bool
    
    var body: some View {
        ////        if isActive {
        ////            OnboardingView(isShowingOnboardingView: $isShowingOnboardingView)
        ////        } else {
        //            ZStack {
        ////                Color("logoColor")
        ////                    .ignoresSafeArea()
        //                Image("toucheImage")
        //                    .resizable()
        //                    .frame(width: 300, height: 300)
        //                    .cornerRadius(10)
        //            }
        //            .onAppear {
        //                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
        ////                    self.isActive = true
        //                }
        //            }
        ////        } //
        ZStack(alignment: .center) {
            LinearGradient(
                stops: [
                    .init(color: Color(hex: "#F1198B") ?? .clear, location: 0.4),
                    .init(color: Color(hex: "#51A2D7") ?? .clear , location: 0.7),
                ],
                startPoint: .bottomLeading,
                endPoint: .topTrailing
            )
            .blendMode(.normal)
            
            LinearGradient(
                stops: [
                    .init(color: Color(hex: "#FB") ?? .clear .opacity(0.91), location: 0.05),
                    .init(color: .clear, location: 0.3),
                    .init(color: Color(hex: "#3C0C79") ?? .clear , location: 0.8),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .blendMode(.screen)
            
            Circle()
                .fill(Color(hex: "#FB") ?? .clear)
                .frame(width: 200)
                .blur(radius: 60, opaque: false)
                .offset(
                    x: -200,
                    y: -200
                )
            
//            Circle()
//                .fill(Color(hex: "#F1198B") ?? .clear)
//                .frame(width: 200)
//                .padding([.leading], 100)
//                .padding([.bottom], 100)
//                .blur(radius: 50, opaque: false)
//                .offset(
//                    x: -10,
//                    y: -10
//                )
            
            Circle()
                .fill(Color.purple)
                .saturation(0.7)
                .frame(width: 300)
                .blur(radius: 80, opaque: false)
                .offset(
                    x: 300,
                    y: 300
                )
            
            Image("touche")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 50)
            
            //            HStack(alignment: .center, spacing: 16.0) {
            //                ForEach(logo.indices, id: \.self) { i in
            //                    Text(logo[i])
            //                        .font(.system(size: 60, weight: .heavy, design: .default))
            //                        .fontWeight(.bold)
            //                        .foregroundColor(.toucheWhite)
            //                }
            //            }
        }
        .ignoresSafeArea()
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
