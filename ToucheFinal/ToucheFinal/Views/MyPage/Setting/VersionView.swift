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
                
                Image("AppIcon")
                    .resizable()
                    .cornerRadius(20)
                Text("현재 버전: 1.0")
                Spacer()
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

struct VersionView_Previews: PreviewProvider {
    static var previews: some View {
        VersionView()
    }
}
