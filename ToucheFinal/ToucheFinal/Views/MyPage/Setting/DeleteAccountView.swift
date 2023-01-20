//
//  DeleteAccountView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/19.
//

import SwiftUI

struct DeleteAccountView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var selection = "불만"
    let reasonForDelete: [String] = ["This app is not useful.", "There is no speciality in the app.", "There is no speciality in the app.", "I'll enter the reason directly."]
    
    @State private var showTextField: Bool = false
    @State private var selectedReason: String = ""
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                
                Text("Delete Account")
                    .font(.system(size: 27))
                    .fontWeight(.bold)
                
                    .padding(.bottom,20)
                Text("Do you have any compliments?\nYou can contact our Customer Service first.\nIf you want a delete account,\nPlease fill in the space below.")
                    .padding(.bottom,20)
                HStack{
                    VStack(alignment: .trailing){
                        Text("Account ID")
                            .padding(.bottom,32)
                        Text("Reason")
                    }
                    
                    VStack(alignment: .leading){
                        Text("유저 아이디")
                        Picker("Select your reason", selection: $selection){
                            ForEach(reasonForDelete, id:\.self){
                                Text($0)
                                
                            }
                        }
                        .pickerStyle(.automatic)
                        .tint(.black)
                        .frame(width: 290, height: 50)
                        .offset(x:-50, y:14)
                    }
                }.padding(.bottom,20)
                Spacer()
                HStack{
                    Image(systemName: "phone")
                    Text("contactus@touche.com")
                }.offset(x:50)
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
        }
    }
}

struct DeleteAccountView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountView()
    }
}
