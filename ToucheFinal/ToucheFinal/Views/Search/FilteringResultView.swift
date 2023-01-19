//
//  FilteringResultView.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/01/18.
//

import SwiftUI

struct FilteringResultView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var perfume: Perfume
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                
                HStack{
                    Text("Brand: ")
//                    ForEach(selectedBrand, id:\.self){ item in
//                        Text("\(item.brand)")
//                    }
                }
                Divider()
                
                HStack{
                    Text("Color: ")
                }
                Divider()
                
                HStack{
                    Text("Fragrance Type: ")
                }
                Divider()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                       
                        ForEach(dummy, id: \.self.perfumeId) { data in
                            NavigationLink {
                                // 해당 향수 디테일 뷰로 이동
                            } label: {
                                PerfumeCell(perfume: data)
                            }

                        }
//                        ForEach(queryResult, id: \.self) { value in
//                            NavigationLink(destination: DetailView(perfume: value), label:{
//                                LotCommentsCellView(perfume: value)
//
//                            })
//
//                        }
                    }
                }
                
            }
            .padding([.leading, .trailing])
            .onAppear {
//                self.queryResult = query()
            }
        }
    }
}

struct FilteringResultView_Previews: PreviewProvider {
    static var previews: some View {
        FilteringResultView(perfume: Perfume(perfumeId: "P258612",
                                             brandName: "CHANEL",
                                             displayName: "CHANCE EAU TENDRE Eau de Toilette",
                                             heroImage: "https://www.sephora.com/productimages/sku/s2238145-main-grid.jpg",
                                             image450: "https://www.sephora.com/productimages/sku/s2238145-main-grid.jpg",
                                             fragranceFamily: "Fresh",
                                             scentType: "Fresh Fruity Florals",
                                             keyNotes: ["Citron", "Jasmine", "Teakwood"],
                                             fragranceDescription: "The delicate and unexpected fruity-floral fragrance for women creates a soft whirlwind of happiness, fantasy, and radiance.",
                                             likedPeople: ["1", "2"],
                                             commentCount: 154,
                                             totalPerfumeScore: 616
                                            ))
    }
}

