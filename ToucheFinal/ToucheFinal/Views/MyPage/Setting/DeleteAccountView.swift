//
//  DeleteAccountView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/19.
//

import SwiftUI
import FirebaseAuth

struct DeleteAccountView: View {
    enum ReasonForDelete: String, CaseIterable, Identifiable {
        case notUse = "This app is not helpful."
        case notSpecial = "Can't find right products."
        case not = "Too busy / Too distracting."
        case enterReason = "Enter directly."

        var id: Self { self }
    }
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userInfoStore: UserInfoStore

//    let reasonForDelete: [String] = ["This app is not useful.", "There is no speciality in the app.", "There is no speciality in the app.", "I'll enter the reason directly."]
    
    @State private var selection = ReasonForDelete.notUse
    @State private var showTextField: Bool = false
    @State private var selectedReason: String = ""
    @State private var reasonForDeleteText: String = ""
    @State private var showAlert: Bool = false
    @State private var showConfirmDelete = false
    @State private var isDeleting = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginFailActive: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading){
                    Group {
                        Text("Delete Account")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom)
                        
                        Text("Do you have any complaints?")
                            .padding(.bottom, 5)
                        HStack{
                            Image(systemName: "envelope")
                            Text("contactus@touche.com")
                        }
                        .padding(.bottom)
                        Text("If you want to delete account,\nPlease fill in the space below.")
                            .padding(.bottom)
                    }
                    Group{
                        HStack {
                            Text("Account ID: ")
                                .bold()
                            Text(userInfoStore.userInfo?.userEmail ?? "")
                        }
                        .padding(.bottom, 7)
                        .padding(.top, 15)
                        
                        Text("Confirm your password")
                            .bold()

                        SecureField("Enter Password", text: $password)
                            .textInputAutocapitalization(.never)
                            .frame(height: 40)
                            .padding(.top, -8.5)
                            .padding(.bottom, 7)
                            .textFieldStyle(.roundedBorder)

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
                                TextField("Provide reason.", text: $reasonForDeleteText, axis: .vertical)
                                    .padding(5)
                                    .keyboardType(.alphabet)
                                    .modifier(KeyboardTextField())        
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, minHeight: 130)
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
                        .opacity(selection == .enterReason ? 1 : 0)
                    }
                    // enterReson 선택 시 TextField 보임
                    Button(action: {
                        showAlert.toggle()
                    }) {
                        Text("Delete Account")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 46)
                            .background(.gray)
                            .cornerRadius(7)
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Delete Account"), message: Text("You can cancel the action\nvia the left button."), primaryButton: .destructive(Text("Delete"), action: {
                                    Task{
                                        if await userInfoStore.deleteAccount(email: email, password: password) {
                                            userInfoStore.userInfo = nil
                                            dismiss()
                                        } else {
                                            loginFailActive.toggle()
                                        }
                                    }
                                }), secondaryButton: .cancel(Text("Cancel")))
                            }
                            .alert("Faill", isPresented: $loginFailActive) {
                                Button("OK"){
                                }
                            } message: {
                                Text("아이디 또는 비밀번호가 일치하지 않습니다. 다시 한번 확인해주세요.")
                            }
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
                .padding()
                .onTapGesture {
                  hideKeyboard()
                }
            }
        }
    }
}

struct DeleteAccountView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountView()
            .environmentObject(UserInfoStore())
    }
}
