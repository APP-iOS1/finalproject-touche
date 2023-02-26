//
//  SignOutView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI

struct SignOutView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("To use more features")
                        .font(.title)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Spacer()
                }
                .frame(height: 80)
                .padding(.leading, 20)
                .padding(.top, -35)
                HStack{
                    NavigationLink {
                        LogInSignUpView(selectedIndex: 0)
                    } label: {
                        Text("Sign In")
                            .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 46)
                            .background(.black)
                            .foregroundColor(.white)
                            .cornerRadius(7)
                    }.tint(.black)
                    
                    NavigationLink {
                        LogInSignUpView(selectedIndex: 1)
                    } label: {
                        Text("Sign Up")
                            .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 46)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7).stroke(Color.black, lineWidth: 0.5)
                                    .cornerRadius(7)
                            )
                    }.tint(.white)
                    
                }
                .padding(.top, -15)
                .padding(.bottom)
                
                Divider()
                
                Spacer()
                GuideView()
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink {
                        SettingView()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.black)
                    }
                }
            }
        } // NAVIGATIONSTACK
        .padding(.top, 1)
    }
}

struct SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutView()
    }
}
