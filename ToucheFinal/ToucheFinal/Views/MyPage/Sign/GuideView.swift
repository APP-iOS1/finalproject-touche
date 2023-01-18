//
//  GuideView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI

struct GuideView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                Image("love")
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Spacer()
                
                Text("You can collect only your favorite products.")
                    .frame(width: 200)
                
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Image("comment")
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Spacer()
                
                Text("You can write reviews of perfumes you have used.")
                    .frame(width: 200)
                
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
