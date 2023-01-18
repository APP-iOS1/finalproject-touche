//
//  SephoraFirebaseView.swift
//  ToucheFinal
//
//  Created by 서광현 on 2023/01/17.
//

import SwiftUI

//TODO: Sephora Data -> Firebase/Firestore 옮기기
/// 1. Sephora Data Fetching 되는가? **[OK!]**
/// 2. 원하는 데이터만 선택해서 Firestore에 저장되는가?
struct SephoraFirebaseView: View {
    @State private var page = 1
    @StateObject var store: APIStore = APIStore()
    
    var body: some View {
        VStack {
            Stepper(value: $page, step: 1) {
                Text("\(page)")
                    .frame(maxWidth: .infinity, alignment: .center)
            } onEditingChanged: {
                if $0 { store.reset() }
            }
            
            Button("데이터 보내기") {
                // 7 page까지 완료
                store.fetchlistDataAndPostToFirestore(page: page)
//                store.hi()
            }
            
            Text(store.notice)
        }
    }
}

struct SephoraFirebaseDetailView: View {
    @StateObject var store: APIStore = APIStore()
    
    var body: some View {
        List(store.products, id: \.productId) { product in
            Button {
                store.fetchDetailData(product: product)
            } label: {
                HStack {
                    Text(product.productId)
                    Spacer()
                    Image(systemName: "checkmark")
                        .opacity(0)
                }                
            }
            .foregroundColor(.black)

        }
        .overlay(alignment: .center, content: {
            Text("데이터 없음")
                .opacity(store.products.isEmpty ? 1 : 0)
        })
        .refreshable(action: store.refreshProductData)
    }
}

struct SephoraFirebaseView_Previews: PreviewProvider {
    static var previews: some View {
        SephoraFirebaseView()
    }
}

// sephora -> products/detail -> ld, image450
// firestore -> temps(collection) -> productId -> products/detail(sephora) -> ld, image450 -> temp2(collection) ->  perfumeId, brandName , displayName,( longDescription ), heroImage

