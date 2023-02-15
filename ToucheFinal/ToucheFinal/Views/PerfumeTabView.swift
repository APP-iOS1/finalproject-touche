//
//  PerfumeTabView.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/18.
//

import SwiftUI
import FirebaseFirestoreSwift
import AlertToast

struct PerfumeTabView: View {
    @FirestoreQuery(collectionPath: "Perfume") var perfumesDB: [Perfume]
    @EnvironmentObject var userInfoStore: UserInfoStore
    @EnvironmentObject var filterViewModel: FilterViewModel
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
                            HomeView(selectedIndex: $selectedIndex)
                        case 1:
                            PaletteView()
                        case 2:
                            MagazineView()
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
                    fetchPerfumeNamesToUserDefaults()
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        /// 없는 정보로 로그인 할때 알럿
        .toast(isPresenting: $userInfoStore.isShowingFailAlert) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: "Incorrect Information!", subTitle: "Please check email or password", style: .style(titleColor: Color.red, subTitleColor: Color.black))
        }
        
        /// 로그인 성공시 알럿
        .toast(isPresenting: $userInfoStore.isShowingSuccessAlert) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: "Welcome to Touché !", subTitle: "Sign in Success", style: .style(titleColor: Color.blue))
        }
        
        /// 로그 아웃 성공시 알럿
        .toast(isPresenting: $userInfoStore.isShowingSignoutAlert) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: "Sign out complete.", subTitle: "See you again!", style: .style(titleColor: Color.blue, subTitleColor: Color.black))
        }
        
        /// ScentTypeDescriptionView 고른 색상 한개 이하일때 알럿
        .toast(isPresenting: $userInfoStore.isShowingScentTypeDesciptionAlert) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: "Notice", subTitle: "At least __One Color__ must be selected")
        }
        
        //MARK: 필터링 개수제한 팝업
        .toast(isPresenting: $filterViewModel.isShowingOverCheckedBrandAlert) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: "Notice", subTitle: "You can select up to 10 brands.")
        }
        
        .toast(isPresenting: $filterViewModel.isShowingOverCheckedColorAlert) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: "Notice", subTitle: "You can select up to 10 colors.")
        }

    }
    
    /// Firebase 로부터 향수 이름을 받아온다
    func fetchPerfumeNamesToUserDefaults() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            // print("perfumesDB.count : \(perfumesDB.count)")
            // print("USERDEFAULTS . CountOfDB : \(NameOfAllPerfumes.count)")
            
            /// 로컬 향수 이름들의 갯수와 BD 향수 이름 개수가 다를 경우 향수 이름들 다시 패치한다

            //  if NameOfAllPerfumes.count != perfumesDB.count {
            if NameOfAllPerfumes.isEmpty {
                print("향수 개수 다름!! 향수 이름 패치 시작")
                var searchResults: [String] {
                    let perfumeNames = perfumesDB.filter { perfume in
                        perfume.displayName != ""
                    }
                        .map { $0.displayName}
                    return perfumeNames
                }
                
                UserDefaults.standard.set(searchResults, forKey: "NameOfAllPerfumes")
                // print("perfumesDB.count : \(perfumesDB.count)")
                // print("USERDEFAULTS . CountOfDB : \(NameOfAllPerfumes.count)")
            } else {
                print("향수 이름 개수 데이터 변동 없음.")
            }
        }
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
