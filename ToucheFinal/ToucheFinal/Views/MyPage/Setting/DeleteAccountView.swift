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

    @EnvironmentObject var userInfoStore: UserInfoStore

//    let reasonForDelete: [String] = ["This app is not useful.", "There is no speciality in the app.", "There is no speciality in the app.", "I'll enter the reason directly."]

    @State private var showTextField: Bool = false
    @State private var selectedReason: String = ""
    @State private var reasonForDeleteText: String = ""

    var body: some View {
        NavigationView {
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
                    Text("Account ID:")
                        .bold()
                    Text("User ID")
                }

                HStack {
                    Text("Reason:")
                        .bold()
                    Picker("Select your reason", selection: $selection){
                                                ForEach(ReasonForDelete.allCases, id:\.self) {
                                                    Text($0.rawValue)
                                                }
                                            }
                                            .tint(.black)
                                            .frame(width: 290, alignment: .leading)
                                            .padding(-10)
                }

                VStack {
                    VStack {

                        TextField("Enter your Text", text: $reasonForDeleteText, axis: .vertical)
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
                    userInfoStore.deleteAccount()
                }) {
                    Text("Delete Account")
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
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .frame(height: 700)
            .padding()


        }

    }
}

struct DeleteAccountView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountView()
    }
}
