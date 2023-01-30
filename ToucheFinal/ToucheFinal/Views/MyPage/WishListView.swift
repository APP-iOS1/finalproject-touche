//
//  WishListView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/20.
//

import SwiftUI

struct WishListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let wishLists = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
     
        NavigationStack{
            VStack(alignment: .leading){
                
                Text("My Wish List")
                    .font(.title)
                    .fontWeight(.medium)
                   
            ScrollView(showsIndicators: false){
                LazyVGrid(columns: wishLists){
                    ForEach(0..<20){ _ in
                        WishListPerfumeCell(perfume: dummy[0])
                    }
                }
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                Button("back"){
                    dismiss()
                }
            }
        }
    }
    }
}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView()
    }
}
