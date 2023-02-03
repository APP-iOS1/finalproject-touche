//
//  HomeView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import SwiftUI

import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift

struct HomeView: View {
    
    @State private var isShowingPromotion: Bool = true
    @State private var perfumes: [Perfume] = []
    @StateObject var homewViewModel = HomeViewModel()
    
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    var rows: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let mostSearchedBrands = ["Sol de Janeiro", "Carolina Herrera", "CHANEL", "Valentino", "Yves Saint Laurent", "Dior", "BURBERRY"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
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
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 24.0) {
                                ForEach(homewViewModel.recomendedPerfume.prefix(6), id: \.self.perfumeId) { perfume in
                                    NavigationLink {
                                        PerfumeDetailView(perfume: perfume)
                                    } label: {
                                        PerfumeCell(perfume: perfume)
//                                        PerfumeCellModified(perfume: perfume, show: $show, animation: animation)
                                    }
                                }
                            }
                            .padding()
                            .padding(.top, -11)
                        }
                        .frame(height: 240)

                        // MARK: 최근 클릭한 향수
                        VStack(alignment: .leading, spacing: 0.0) {
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
                                HStack(spacing: 24.0) {
                                    ForEach(homewViewModel.recentlyViewed7Perfumes, id: \.self.perfumeId) { perfume in
                                        NavigationLink {
                                            PerfumeDetailView(perfume: perfume)
                                        } label: {
                                            PerfumeCell(perfume: perfume)
                                        }
                                    }
                                }
                                .padding()
                                .padding(.top, -11)
                            }
                            .frame(height: 240)
                            
                        }
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
                }
                .onAppear{
                    if (userInfoStore.user != nil) {    //  로그인이 아닌 상태일 때
                        
                        //  **비동기 처리**
                        userInfoStore.fetchUser(user: userInfoStore.user)   //  애가 끝나기 전에
                        homewViewModel.filterRecentlyViewed7Perfumes(perfumesId: userInfoStore.userInfo?.recentlyPerfumesId ?? [])  //  너가 실행됨
                    } else {    //  로그인 했을 경우
                     
                        let recentlyPerfumesId = UserDefaults.standard.array(forKey: "recentlyPerfumesId") as? [String] ?? []
                        homewViewModel.filterRecentlyViewed7Perfumes(perfumesId: recentlyPerfumesId)
                    }
                    
                    let selectedScentType = UserDefaults.standard.array(forKey: "selectedScentTypes") as? [String] ?? []
                    
                    homewViewModel.filterRecommendedPerfumes(selectedScentTypes: selectedScentType)
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
            .navigationBarItems(trailing: NavigationLink(destination: SearchView()) {
                Image(systemName: "magnifyingglass").foregroundColor(.black)
            })
            .navigationBarItems(trailing: NavigationLink(destination: FilterView()) {
                Image(systemName: "slider.vertical.3").foregroundColor(.black)
            })
            .navigationBarItems(leading: NavigationLink(destination: PerfumeDescriptionView()) {
                Image(systemName: "info.circle").foregroundColor(.black)
            })
            .background( Color("CustomGray") )
        }
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
            .environmentObject(UserInfoStore())
    }
}
