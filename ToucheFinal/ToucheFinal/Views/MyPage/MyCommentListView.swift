//
//  MyCommentListView.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/01/20.
//

import SwiftUI

struct MyCommentListView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<10) { _ in
                VStack{
                    MyPageMyCommentCell(perfume: dummy[0], comment: commentDummy[0])
                        .padding(.bottom, 30)
                }
            }
            //                .frame(height: 80)
            .navigationTitle("My Comment")
        }
    }
}

struct MyCommentListView_Previews: PreviewProvider {
    static var previews: some View {
        MyCommentListView()
    }
}
