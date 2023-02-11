//
//  PerfumeTabView.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/18.
//

import SwiftUI
import FirebaseFirestoreSwift

struct PerfumeTabView: View {
    @FirestoreQuery(collectionPath: "Perfume") var perfumesDB: [Perfume]
    @State var NameOfAllPerfumes: [String] = UserDefaults.standard.array(forKey: "NameOfAllPerfumes") as? [String] ?? []
    @State var isShowingOnboardingView: Bool = UserDefaults.standard.object(forKey: "isShowingOnboardingView") as? Bool ?? true
    @State private var selectedIndex = 0
    @State private var touchTab = false
    
    let selectedColors = (UserDefaults.standard.array(forKey: "selectedFragranceTypes") as? [String] ?? [])
    let tabBarNames = ["Home", "Palette", "Magazine", "Profile"]
    var body: some View {
        Group {
            if isShowingOnboardingView {
                OnboardingView(isShowingOnboardingView: $isShowingOnboardingView)
            } else {
                VStack{
                    ZStack() {
                        switch selectedIndex {
                        case 0:
                            HomeView()
                        case 1:
                            MagazineView()
                        case 2:
                            PaletteView()
                        default:
                            LogInRootView()
                        }
                    }
                    Spacer()
                    Divider()
                        .offset(y: -8)
                    HStack{
                        Spacer()
                        
                        ForEach(0..<4) { num in
                            VStack(alignment: .center){
                                Text(tabBarNames[num])
                                    .font(.system(size: 15, weight: .light))
                                    .foregroundColor(selectedIndex == num ? Color(.black) : Color(.tertiaryLabel))
                                    .overlay(alignment: .bottom) {
                                        if selectedIndex == num {
                                            Circle()
                                                .foregroundColor(Color(.black))
                                                .frame(width: 101, height: 4)
                                                .offset(y: 8)
                                        }
                                    }
                            }
                            .gesture(
                                TapGesture()
                                    .onEnded { _ in
                                        selectedIndex = num
                                    }
                            )
                            Spacer()
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 5)
                }
                .onAppear {
                    print(selectedColors)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                        print("perfumesDB.count : \(perfumesDB.count)")
                        print("USERDEFAULTS . CountOfDB : \(NameOfAllPerfumes.count)")
                        
                        /// 로컬 향수 이름들의 갯수와 BD 향수 이름 개수가 다를 경우 향수 이름들 다시 패치한다
                        if NameOfAllPerfumes.count != perfumesDB.count {
                            print("향수 개수 다름!! 향수 이름 패치 시작")
                            var searchResults: [String] {
                                let perfumeNames = perfumesDB.filter { perfume in
                                    perfume.displayName != ""
                                }
                                    .map { $0.displayName}
                                return perfumeNames
                            }
                            
                            UserDefaults.standard.set(searchResults, forKey: "NameOfAllPerfumes")
                            print("perfumesDB.count : \(perfumesDB.count)")
                            print("USERDEFAULTS . CountOfDB : \(NameOfAllPerfumes.count)")
                        } else {
                            print("향수 이름 개수 데이터 변동 없음.")
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


struct PerfumeTabView_Previews: PreviewProvider {
    static var previews: some View {
        PerfumeTabView()
            .environmentObject(ColorPalette())
            .environmentObject(UserInfoStore())
    }
}


//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//    var window: UIWindow?
//    @ObservedObject var perfumestore: PerfumeStore
//    
//    init(window: UIWindow? = nil, perfumestore: PerfumeStore) {
//        self.window = window
//        self.perfumestore = perfumestore
//    }
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        let perfumeTabView = PerfumeTabView()
//        if let windowScene = scene as? UIWindowScene {
//            let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = UIHostingController(rootView: NavigationView {
//                perfumeTabView
//            })
//            self.window = window
//            window.makeKeyAndVisible()
//        }
//    }
//}
