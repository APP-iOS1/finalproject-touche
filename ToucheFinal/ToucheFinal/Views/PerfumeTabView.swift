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
    let tabBarNames = ["Home", "Palette", "Profile"]
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
                        default:
                            LogInRootView()
                        }
                    }
                    Spacer()
                    Divider()
                        .offset(y: -6)
                    HStack{
                        Spacer()
                        
                        ForEach(0..<3) { num in
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
                                .padding(.leading, geometry.size.width / -2.4)
                        case 1:
                            Circle()
                                .foregroundColor(Color(.black))
                                .frame(width: 101, height: 4)
                                .padding(.leading, geometry.size.width / -50)
                            
                        case 2:
                            Circle()
                                .foregroundColor(Color(.black))
                                .frame(width: 101, height: 4)
                                .padding(.leading, geometry.size.width / 1.8)
                        default :
                            Circle()
                                .foregroundColor(Color(.black))
                                .frame(width: 101, height: 4)
                        }
                    }.padding(.top, -5)
                }
                .onAppear {
                    print(selectedColors)
                }
            }
        }
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
    }
}
