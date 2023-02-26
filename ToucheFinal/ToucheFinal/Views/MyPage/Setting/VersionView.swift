//
//  VersionView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/15.
//

import SwiftUI

struct VersionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            VStack{
                
                Image("touche3")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(15)
                    .padding(.top, 30)
                    .padding(.bottom, 17)
                Text("Version: 1.0")
                Spacer()
            }
            .navigationBarTitle("Version", displayMode: .inline)
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

struct VersionView_Previews: PreviewProvider {
    static var previews: some View {
        VersionView()
    }
}
