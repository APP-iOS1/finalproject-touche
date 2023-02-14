//
//  ContactUsView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/13.
//

import SwiftUI

struct ContactUsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            VStack{
                Image("touche2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 50)
                VStack{
                    Text
                    HStack{
                        Image(systemName: "envelope")
                        Text("contactus@touche.com")
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
