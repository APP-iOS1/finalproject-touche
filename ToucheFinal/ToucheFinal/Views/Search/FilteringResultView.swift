//
//  FilteringResultView.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/01/18.
//

import SwiftUI
import FirebaseFirestoreSwift

// TODO: - FilterView와 연결하기
// 1. PerfumesGridView 참고
// 2. 향수클릭하면 PerfumeDetailView로 뷰로 이동
struct FilteringResultView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let queries: [String]
    var perfumes: FirestoreQuery<[Perfume]>
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    init(field: String, queries: [String]) {
        self.queries = queries
        perfumes = FirestoreQuery<[Perfume]>(collectionPath: "Perfume", predicates: [.whereField(field, isIn: queries)])
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                //MARK: symbol제거 후 왼쪽패딩 추가
//                Image(systemName: "slider.vertical.3")
                Text("Result ")
                    .fontWeight(.semibold)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(queries, id: \.self) {
                            Text($0)
                                .padding(8)
                                .background {
                                    Capsule()
                                        .fill(Color.gray.opacity(0.2))
                                }
                        }
                    }
                }
            }
            .frame(height: 40.0)
            .padding(.leading)
            
            Divider()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(perfumes.wrappedValue, id: \.perfumeId) { perfume in
                        NavigationLink {
                            PerfumeDetailView(perfume: perfume)
                        } label: {
                            PerfumeCell(perfume: perfume)
                        }
                        
                    }
                }
                //MARK: 윗아래 그리드셀 조금 잘리는 문제로 패딩 추가
                .padding(.top, 5)
                .padding(.bottom, 30)
            }
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .foregroundColor(.black)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FilteringResultView_Previews: PreviewProvider {
    static var previews: some View {
        FilteringResultView(field: "brandName", queries: ["Dior"])
    }
}
