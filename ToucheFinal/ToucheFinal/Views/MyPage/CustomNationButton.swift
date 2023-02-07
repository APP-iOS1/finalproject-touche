//
//  CustomNationButton.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/03.
//

import SwiftUI

struct CustomNationButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                Circle()
                    .fill(.white)
                    .frame(width: 30, height: 30)
                    .shadow(color: .black.opacity(0.3),
                            radius: configuration.isPressed ? 8 : 6,
                            x: configuration.isPressed ? 0 : 6,
                            y: configuration.isPressed ? 0 : 6)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

extension ButtonStyle where Self == CustomNationButton {
    static var customButton : CustomNationButton{
        .init()
    }
}

struct CustomNationButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Button{
                print("3")
            } label: {
                Text("🏳️‍🌈")
            }
            .buttonStyle(CustomNationButton())
        }
    }
}
