//
//  HomeView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift
import AlertToast

struct HomeView: View {
    
    @State private var isShowingPromotion: Bool = true
    @State private var perfumes: [Perfume] = []
    @Binding var selectedIndex: Int
    @EnvironmentObject var perfumeStore: PerfumeStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    @StateObject var magazineStore: MagazineStore = MagazineStore()
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    var rows: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    let mostSearchedBrands = ["Sol de Janeiro", "Carolina Herrera", "CHANEL", "Valentino", "Yves Saint Laurent", "Dior", "BURBERRY"]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(alignment: .leading) {
                        MagazineBanner(magazine: magazineStore.magazines.first ?? Magazine(id: "", title: "", subTitle: "", contentImage: "", bodyImage: "", createdDate: 0, perfumeIds: []))
                            .onTapGesture {
                                selectedIndex = 2
                            }
                            .tint(.white)
                    }
                    //                        Spacer()
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
                    
                    
                    // MARK: - Recommend Perfume for You
                    VStack(alignment: .leading, spacing: 0.0) {
                        HStack(alignment: .bottom) {
                            Text("RECOMMENDATION FOR YOU")
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
                    
                    // MARK: 최근 클릭한 향수
                    if !perfumeStore.recentlyViewedPerfumes.isEmpty {
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
                    }
                    
                }

                .onAppear{
                    print(Auth.auth().currentUser?.isEmailVerified)
                    Task {
                        if userInfoStore.user?.isEmailVerified ?? false {    //  로그인
                            await userInfoStore.fetchUser(user: userInfoStore.user)
                            guard let recentlyPerfumesId = userInfoStore.userInfo?.recentlyPerfumesId else {return}
                            if !recentlyPerfumesId.isEmpty {
                                await perfumeStore.readRecentlyPerfumes(perfumesId: recentlyPerfumesId)
                            }
                        } else {    //  비로그인
                            let recentlyPerfumesId = UserDefaults.standard.array(forKey: "recentlyPerfumesId") as? [String] ?? []
                            if !recentlyPerfumesId.isEmpty {
                                await perfumeStore.readRecentlyPerfumes(perfumesId: recentlyPerfumesId)
                            }
                        }
                        let selectedScentTypes = UserDefaults.standard.array(forKey: "selectedScentTypes") as? [String] ?? []
                        let perfumesId = setRecomendedPerfumesId(perfumesId: selectedScentTypes)
                        await perfumeStore.readRecomendedPerfumes(perfumesId: perfumesId)
                        await perfumeStore.readMostCommentsPerfumes()
                        await magazineStore.readMagazines()

                    }
                    perfumeStore.recentSearches = UserDefaults.standard.array(forKey: "recentSearchesUD") as? [String] ?? [String]()
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
//        HomeView(selectedIndex: .constant(0))
//            .environmentObject(UserInfoStore())
//            .environmentObject(PerfumeStore())
//            .environmentObject(MagazineStore())
//    }
//}
