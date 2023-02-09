//
//  PerfumeTabView.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/18.
//

import SwiftUI

struct PerfumeTabView: View {
    
    @State private var selectedIndex = 0
    @State private var touchTab = false
    @State var isShowingOnboardingView: Bool = UserDefaults.standard.bool(forKey: "isShowingOnboardingView")
    let selectedColors = (UserDefaults.standard.array(forKey: "selectedFragranceTypes") as? [String] ?? [])
    let tabBarNames = ["Home", "Magazine", "Palette", "Profile"]
    var body: some View {
        GeometryReader{geometry in
            if isShowingOnboardingView {
                OnboardingView(isShowingOnboardingView: $isShowingOnboardingView)
            } else {
                VStack{
                    ZStack() {
                        switch selectedIndex{
                        case 0:
                            HomeView()
                        case 1:
                            PaletteView()
                        case 2:
                            PaletteView()
                        default:
                            LogInRootView()
                        }
                    }
                    Spacer()
                    Divider()
                        .offset(y: -6)
                    HStack{
                        Spacer()
                        
                        ForEach(0..<4) { num in
                            VStack(alignment: .center){
                                Text(tabBarNames[num])
                                    .font(.system(size: 15, weight: .light))
                                    .foregroundColor(selectedIndex == num ? Color(.black) : Color(.tertiaryLabel))
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
                    
                    HStack{
                        switch selectedIndex{
                        case 0 :
                            Circle()
                                .foregroundColor(Color(.black))
                                .frame(width: 101, height: 4)
                                .padding(.leading, geometry.size.width / -2.098)
                        case 1:
                            Circle()
                                .foregroundColor(Color(.black))
                                .frame(width: 101, height: 4)
                                .padding(.leading, geometry.size.width / -4.5)
                            
                        case 2:
                            Circle()
                                .foregroundColor(Color(.black))
                                .frame(width: 101, height: 4)
                                .padding(.leading, geometry.size.width / 3.84)
                            
                        case 3:
                            Circle()
                                .foregroundColor(Color(.black))
                                .frame(width: 101, height: 4)
                                .padding(.leading, geometry.size.width / 1.45)
                            
                        default :
                            Circle()
                                .foregroundColor(Color(.black))
                                .frame(width: 101, height: 4)
                        }
                    }
                    .padding(.top, -5)
                }
                .onAppear {
                    print(selectedColors)
                    
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    func randomColor(color: [String]) -> [String] {
        var randColors: Set<String> = []
        while randColors.count != min(10, color.count) {
            if let randColor = color.randomElement() {
                randColors.insert(randColor)
            }
        }
        return Array(randColors)
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
