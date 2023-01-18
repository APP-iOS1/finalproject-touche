//
//  SignOutView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI

struct SignOutView: View {
    @Binding var user: Bool
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("If you want to use the wish list,\n ")
                    Spacer()
                }
                .frame(height: 80)
                .padding(.horizontal, 20)
                
                HStack{
                    NavigationLink {
                        LogInSignUpView(selectedIndex: 0, user: $user)
                    } label: {
                        Text("Sign In")
                            .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 44)
                            .background(.black)
                            .foregroundColor(.white)
                            .cornerRadius(7)
                    }.tint(.black)
                    
                    NavigationLink {
                        LogInSignUpView(selectedIndex: 1, user: $user)
                    } label: {
                        Text("Sign Up")
                            .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 44)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7).stroke(Color.black, lineWidth: 0.5)
                                    .cornerRadius(7)
                            )
                    }.tint(.white)
                    
                }
                .padding(.bottom)
                
                Divider()
                
                Spacer()
                GuideView()
                Spacer()
            }
        }
    }
}

struct SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutView(user: .constant(true))
    }
}
