//
//  HomeView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import SwiftUI

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State var isShowingPromotion: Bool = true
    var rows: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let mostSearchedBrands = ["Sol de Janeiro", "Carolina Herrera", "CHANEL", "Valentino", "Yves Saint Laurent", "Dior", "BURBERRY"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // MARK: 프로모션
                    Rectangle()
                        .frame(height: 350)
                        .overlay(alignment: .bottom) {
                            HStack{
                                Text("NEWLY ADDED\nPERFUME")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .padding()
                        .background(.black)
                    
                    if isShowingPromotion{
                        HStack {
                            VStack(alignment: .leading) {
                                Text("CHECK OUT THE PROMOTIONS.")
                                    .foregroundColor(.black)
                                
                                Text("MORE")
                                    .underline()
                                    .foregroundColor(.black)
                            }
                            Spacer()
                            Button {
                                isShowingPromotion = false
                            } label: {
                                Text("CLOSE")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color(.gray).opacity(0.4))
                        .padding(.top, -10)
                    }
                    
                    // MARK: 브랜드 검색 순위
                    Text("BRAND TOP 7")
                        .modifier(TextViewModeifier())
                        .padding(.bottom, -15)
                    
                    ForEach(mostSearchedBrands, id: \.self) { brand in
                        Text(brand)
//                            .font(.system(size: 25))
                            .font(.callout)
                            .bold()
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .lineSpacing(4.5)
                            .padding(.leading)
                    }
                    // MARK: 최근 클릭한 향수
                    Text("RECENTLY VIEWED")
                        .modifier(TextViewModeifier())
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(dummy, id: \.self.perfumeId) { perfume in
                                NavigationLink {
                                    PerfumeDetailView(perfume: perfume)
                                } label: {
                                    PerfumeCell(perfume: perfume)
                                }
                            }
                        }
                        .padding(.leading)
                    }.padding(.bottom, 15)
                    
                    // MARK: 코멘트 많이 달린 향수
                    Text("RECENTLY TOP COMMNENTS 20")
                        .modifier(TextViewModeifier())
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHGrid(rows: rows){
                            ForEach(dummy, id: \.self.perfumeId) { perfume in
                                NavigationLink {
                                    PerfumeDetailView(perfume: perfume)
                                } label: {
                                    PerfumeCell(perfume: perfume)
                                }
                            }
                        }
                        .padding(.leading)
                    }.frame(height: 450)
                }
            }
        }
        .toolbar(content: {
            ToolbarItem {
                NavigationLink {
                    SearchView()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                }
            }
        })
        .padding(.top, 0.1)
        .padding(.bottom, 30)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct TextViewModeifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .font(.system(size: 20))
            .fontWeight(.semibold)
            .padding()
            .padding(.bottom, -5)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
