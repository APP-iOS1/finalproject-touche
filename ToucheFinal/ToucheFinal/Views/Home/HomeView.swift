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
    @EnvironmentObject var perfumeStore: PerfumeStore
    @State var isShowingPromotion: Bool = true
    var rows: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let mostSearchedBrands = ["Sol de Janeiro", "Carolina Herrera", "CHANEL", "Valentino", "Yves Saint Laurent", "Dior", "BURBERRY"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // MARK: 프로모션
                    /*
                    NavigationLink {
                        PerfumeDescriptionView()
                    } label: {
                        Rectangle()
                            .frame(height: 350)
                            .overlay(alignment: .top) {  // 0130 수정 alignment: .bottom을 .top으로 바꿔주었음
                                
                                HStack{
                                    Text("Select Your \nPerfume Colour")
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            }
                            .padding()
                            .background(.black)
                    }
                     */

                    Rectangle()
                        .frame(height: 200)
                        .overlay(alignment: .top) {
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
                    // MARK: Recommend Perfume for You
                    HStack(alignment: .bottom) {
                        Text("RECOMMEND PERFUME FOR YOU")
                            .modifier(TextViewModeifier(isTitleSection: true))
                        Spacer()
                        Button {
                            // TODO: 더보기 액션
                        } label: {
                            Text("more")
                                .modifier(TextViewModeifier(isTitleSection: false))
                        }

                    }

                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(perfumeStore.recentlyViewed7Perfumes, id: \.self.perfumeId) { perfume in
                                NavigationLink {
                                    PerfumeDetailView(perfume: perfume)
                                } label: {
                                    ColorChipPerfumeCell(perfume: perfume)
                                }
                            }
                        }
                        .padding(.leading)
                    }
                    .padding(.bottom, 15)
                    .onAppear {
                        perfumeStore.readViewedPerfumeIdsArrayAtUserInfo()
                    }
                    
//                    // MARK: 브랜드 검색 순위
//                    Text("BRAND TOP 7")
//                        .modifier(TextViewModeifier())
//                        .padding(.bottom, -15)
//
//                    ForEach(mostSearchedBrands, id: \.self) { brand in
//                        Text(brand)
//                        //                            .font(.system(size: 25))
//                            .font(.callout)
//                            .bold()
//                            .fontWeight(.regular)
//                            .foregroundColor(.black)
//                            .lineSpacing(4.5)
//                            .padding(.leading)
//                    }
                    // MARK: 최근 클릭한 향수
                    HStack(alignment: .bottom) {
                        Text("RECENTLY VIEWED")
                            .modifier(TextViewModeifier(isTitleSection: true))
                        Spacer()
                        Button {
                            // TODO: 더보기 액션
                        } label: {
                            Text("more")
                                .modifier(TextViewModeifier(isTitleSection: false))
                        }

                    }
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(perfumeStore.recentlyViewed7Perfumes, id: \.self.perfumeId) { perfume in
                                NavigationLink {
                                    PerfumeDetailView(perfume: perfume)
                                } label: {
                                    PerfumeCell(perfume: perfume)
                                }
                            }
                        }
                        .padding(.leading)
                    }
                    .padding(.bottom, 15)
                    /*
                    .onAppear {
                        perfumeStore.readViewedPerfumeIdsArrayAtUserInfo()
                    }
                     */

                    // MARK: 코멘트 많이 달린 향수
                    /*
                    HStack{
                        Text("RECENTLY TOP COMMNENTS 20")
                            .modifier(TextViewModeifier())
                        NavigationLink {
                            PerfumesGridView(perfumes: dummy, title: "")
                        } label: {
                            Text("More")
                                .bold()
                                .underline()
                        }
                        .tint(.black)
                    }
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHGrid(rows: rows){
                            ForEach(perfumeStore.topComment20Perfumes, id: \.self.perfumeId) { perfume in
                                NavigationLink {
                                    PerfumeDetailView(perfume: perfume)
                                } label: {
                                    PerfumeCell(perfume: perfume)
                                }
                            }
                        }
                        .padding(.leading)
                    }
                    .frame(height: 450)
                    .onAppear {
                        perfumeStore.readTopComment20Perfumes()
                    }
                     */
                }
//                // MARK: - NotoSans 글꼴 이름 찾기
//                .onAppear{
//                    UIFont.familyNames.sorted().forEach { familyName in
//                        print("*** \(familyName) ***")
//                        UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
//                            print("\(fontName)")
//                        }
//                        print("---------------------")
//                    }
//                }
            }
            .navigationBarItems(trailing: NavigationLink(destination: SearchView()) {
                Image(systemName: "magnifyingglass").foregroundColor(.black)
            })
            .navigationBarItems(trailing: NavigationLink(destination: FilterView()) {
                Image(systemName: "slider.vertical.3").foregroundColor(.black)
            })
            .navigationBarItems(leading: NavigationLink(destination: PerfumeDescriptionView()) {
                Image(systemName: "info.circle").foregroundColor(.black)
            })
        }
//        .toolbar(content: {
//            ToolbarItem {
//                NavigationLink {
//                    SearchView()
//                } label: {
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.black)
//                }
//            }
//        })
//        .padding(.top, 0.1)
//        .padding(.bottom, 30)
        
       
    }
}

struct TextViewModeifier: ViewModifier {
    let isTitleSection: Bool
    func body(content: Content) -> some View {
        content
            .foregroundColor(.primary)
            .font(isTitleSection ? .headline : .caption)
            .fontWeight(isTitleSection ? .semibold : .regular)
            .underline(!isTitleSection, pattern: .solid, color: .primary)
            .padding()
            .padding(.bottom, -5)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(PerfumeStore())
    }
}
