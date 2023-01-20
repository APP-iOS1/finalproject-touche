//
//  DeleteAccountView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/19.
//

import SwiftUI

struct DeleteAccountView: View {
    enum ReasonForDelete: String, CaseIterable, Identifiable {
        case notUse = "This app is not useful."
        case notSpecial = "There is no speciality in the app."
        case not = "There is no speciality in the app"
        case enterReason = "I'll enter the reason directly."
        
        var id: Self { self }
    }
    @Environment(\.dismiss) var dismiss
    
    @State private var selection = ReasonForDelete.notUse
    
//    let reasonForDelete: [String] = ["This app is not useful.", "There is no speciality in the app.", "There is no speciality in the app.", "I'll enter the reason directly."]
    
    @State private var showTextField: Bool = false
    @State private var selectedReason: String = ""
    @State private var reasonForDeleteText: String = ""
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                    Text("Delete Account")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    Text("Do you have any compliments?\nYou can contact our Customer Service first.")
                        .padding(.bottom, 5)
                    HStack{
                        Image(systemName: "phone")
                        Text("contactus@touche.com")
                    }
                    .padding(.bottom)
                    Text("If you want a delete account,\nPlease fill in the space below.")
                        .padding(.bottom)
                
                HStack {
                    VStack(alignment: .trailing){
                        Text("Account ID:")
                        Spacer()
                        Text("Reason:")
                    }
                    .bold()
                    .frame(height: 50)
                    
                    //MARK: Picker 부분
                    VStack(alignment: .leading){
                        Text("User ID")
                        Picker("Select your reason", selection: $selection){
                            ForEach(ReasonForDelete.allCases, id:\.self) {
                                Text($0.rawValue)
                            }
                        }
                        .tint(.black)
                        .frame(width: 290, alignment: .leading)
                        .padding(-10)
                    }
                    .frame(width: 260, height: 50, alignment: .leading)
                }
                .padding(.bottom,20)
                
                VStack {
                    VStack {
                        TextField("Review", text: $reasonForDeleteText, axis: .vertical)
                            .padding(5)
                        
                        Spacer()
                    }
                    .frame(width: 360, height: 130)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 0.5)
                    )
                    
                    HStack {
                        Spacer()
                        Text("\(reasonForDeleteText.count)/200")
                            .foregroundColor(.gray)
                    }
                }
                // enterReson 선택 시 TextField 보임
                .opacity(selection == .enterReason ? 1 : 0)
                
                Button(action: {
                    
                }) {
                    Text("Send")
                        .frame(width: 360, height: 46)
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(7)
                }
                .disabled(false)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                    .tint(.black)
                }
            }
            .padding()
            
        }
    }
}

struct DeleteAccountView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountView()
    }
}
