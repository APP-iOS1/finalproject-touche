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
import AlertToast

struct HomeView: View {
    
    @State private var isShowingPromotion: Bool = true
    @State private var perfumes: [Perfume] = []
        
    @EnvironmentObject var perfumeStore: PerfumeStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    var rows: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let mostSearchedBrands = ["Sol de Janeiro", "Carolina Herrera", "CHANEL", "Valentino", "Yves Saint Laurent", "Dior", "BURBERRY"]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Rectangle()
                        .frame(height: 200)
                        .overlay(alignment: .top) {
                            HStack{
                                NavigationLink {
                                    // TODO: NEW ARRIVALS 클릭시 매거진뷰로 이동
            
                                } label: {
                                    Text("NEW ARRIVALS")
                                    //Text("NEW ARRIVALS".localized(language))
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                Spacer()
                            }
                        }
                        .padding()
                        .background(.black)
                    //TODO: 프로모션 들어오면 사용할 기능
                    Group {
                        //                    if isShowingPromotion{
                        //                        HStack {
                        //                            VStack(alignment: .leading) {
                        //                                Text("CHECK OUT THE PROMOTIONS.")
                        //                                    .foregroundColor(.black)
                        //
                        //                                Text("MORE")
                        //                                    .underline()
                        //                                    .foregroundColor(.black)
                        //                            }
                        //                            Spacer()
                        //                            Button {
                        //                                isShowingPromotion = false
                        //                            } label: {
                        //                                Text("CLOSE")
                        //                                    .foregroundColor(.gray)
                        //                            }
                        //                        }
                        //                        .padding()
                        //                        .background(Color(.gray).opacity(0.4))
                        //                        .padding(.top, -10)
                        //                    }
                    }
                    
                    // MARK: - Recommend Perfume for You
                    VStack(alignment: .leading, spacing: 0.0) {
                        HStack(alignment: .bottom) {
                            Text("RECOMMENDATION PERFUME FOR YOU")
                                .modifier(TextViewModeifier(isTitleSection: true))
                            Spacer()
                            NavigationLink {
                                MoreRecommendPerfumeView()
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
                    
                        // MARK: 코멘트 많이 달린 향수
                        VStack(alignment: .leading, spacing: 0.0) {
                            HStack(alignment: .bottom) {
                                Text("TOP COMMNENTS 10")
                                    .modifier(TextViewModeifier(isTitleSection: true))
                                Spacer()
                            }
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 24.0) {
                                    ForEach(perfumeStore.mostCommentsPerfumes.prefix(10), id: \.self.perfumeId) { perfume in
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
                        
                    }
                }
                .onAppear{
                    Task {
                        await userInfoStore.fetchUser(user: userInfoStore.user)
                        if userInfoStore.userInfo != nil {    //  로그인 상태일 때
                            guard let recentlyPerfumesId = userInfoStore.userInfo?.recentlyPerfumesId else {return}
                            if !recentlyPerfumesId.isEmpty {
                                await perfumeStore.readRecentlyPerfumes(perfumesId: recentlyPerfumesId)
                            }
                        } else {    //  로그인 했을 경우
                            let recentlyPerfumesId = UserDefaults.standard.array(forKey: "recentlyPerfumesId") as? [String] ?? []
                            if !recentlyPerfumesId.isEmpty {
                                await perfumeStore.readRecentlyPerfumes(perfumesId: recentlyPerfumesId)
                            }
                        }
                        let selectedScentTypes = UserDefaults.standard.array(forKey: "selectedScentTypes") as? [String] ?? []
                        await perfumeStore.readRecomendedPerfumes(perfumesId: setRecomendedPerfumesId(perfumesId: selectedScentTypes))
                        await perfumeStore.readMostCommentsPerfumes()
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

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//            .environmentObject(UserInfoStore())
//            .environmentObject(PerfumeStore())
//    }
//}
