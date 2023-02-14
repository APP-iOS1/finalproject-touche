//
//  LogInSignUpView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI
import SegmentedPicker
import AlertToast

struct LogInSignUpView: View {
    @EnvironmentObject var userInfoStore: UserInfoStore
    @State var selectedIndex: Int = 0
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let titles: [String] = ["Sign In", "Sign Up"]
    var backButtonMark = "chevron.left"
    var body: some View {
        VStack {
            Spacer()
            HStack {
                SegmentedPicker(
                    titles,
                    selectedIndex: Binding(
                        get: { selectedIndex },
                        set: { selectedIndex = $0 ?? 0}),
                    selectionAlignment: .bottom,
                    content: { item, isSelected in
                        Text(item)
                            .foregroundColor(isSelected ? Color.black : Color.gray )
                            .font(.title2)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                    },
                    selection: {
                        VStack(spacing: 0) {
                            Spacer()
                            Color.black.frame(height: 1)
                        }
                    })
                .animation(.easeInOut(duration: 0.3), value: selectedIndex)
                Spacer()
            }
            .padding(.leading, 15)
            
            VStack {
                switch selectedIndex {
                case 0:
                    LogInView()
                default:
                        SignUpView()
                }
                Spacer()
            }
//            .frame(width: UIScreen.main.bounds.width, height: 650)
            Spacer()
        } //VStack
//        .frame(height: 400)
//        .ignoresSafeArea(.keyboard)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: backButtonMark)
                }
                .foregroundColor(.black)
            }
        }
        .navigationBarBackButtonHidden(true)
    } // body
}

struct LogInSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        LogInSignUpView()
    }
}
