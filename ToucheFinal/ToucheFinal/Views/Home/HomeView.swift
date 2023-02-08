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
        
    @EnvironmentObject var perfumeStore: PerfumeStore
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
                                Text("NEW ARRIVALS")
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
                    VStack(alignment: .leading, spacing: 0.0) {
                        HStack(alignment: .bottom) {
                            Text("RECOMMENDATION PERFUME FOR YOU")
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
                                ForEach(perfumeStore.recomendedPerfumes.prefix(6), id: \.self.perfumeId) { perfume in
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
                                    ForEach(perfumeStore.recentlyViewedPerfumes, id: \.self.perfumeId) { perfume in
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
                    if userInfoStore.user != nil {    //  로그인 상태일 때
                        Task {
                            await userInfoStore.fetchUser(user: userInfoStore.user)
                            guard let recentlyPerfumesId = userInfoStore.userInfo?.recentlyPerfumesId else {return}
                            if !recentlyPerfumesId.isEmpty {
                                await perfumeStore.readRecentlyPerfumes(perfumesId: recentlyPerfumesId)
                            }
                        }
                    } else {    //  로그인 했을 경우
                        Task {
                            let recentlyPerfumesId = UserDefaults.standard.array(forKey: "recentlyPerfumesId") as? [String] ?? []
                            if !recentlyPerfumesId.isEmpty {
                                await perfumeStore.readRecentlyPerfumes(perfumesId: recentlyPerfumesId)
                            }
                        }
                    }
                    
                    Task {
                        let selectedScentTypes = UserDefaults.standard.array(forKey: "selectedScentTypes") as? [String] ?? []
                        await perfumeStore.readRecomendedPerfumes(perfumesId: setRecomendedPerfumesId(perfumesId: selectedScentTypes))
                    }
                    
                }
                .navigationBarItems(trailing: NavigationLink(destination: SearchView()) {
                    Image(systemName: "magnifyingglass").foregroundColor(.black)
                })
                .onAppear {
                    perfumeStore.recentSearches = UserDefaults.standard.array(forKey: "recentSearchesUD") as? [String] ?? [String]()
                }
                .navigationBarItems(trailing: NavigationLink(destination: FilterView()) {
                    Image(systemName: "slider.vertical.3").foregroundColor(.black)
                })
                .navigationBarItems(leading: NavigationLink(destination: PerfumeDescriptionView()) {
                    Image(systemName: "info.circle").foregroundColor(.black)
                })
            }
        }
    }
    func setRecomendedPerfumesId(perfumesId: [String]) -> [String] {
        return Array(perfumesId.prefix(10))
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
            .environmentObject(PerfumeStore())
    }
}
