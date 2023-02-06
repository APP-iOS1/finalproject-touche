//
//  TESTVIEWTS.swift
//  ToucheFinal
//
//  Created by 김태성 on 2023/01/31.
//

import SwiftUI

struct PaletteView: View {
    @State private var angle: Angle = .zero
    @State private var radius: CGFloat = 140.0
    @State private var animation: Animation? = nil
    @State private var txt = ""
    @State private var isTapped = false
    @State private var scentTypeCount: [String: Double] = [:]
    @State private var selectedColor: Color = Color("customGray")
    @State var isSignin: Bool = false
    @State var navLinkActive = false
    @State var perfumes: [Perfume] = []
    
    @EnvironmentObject var perfumeStore: PerfumeStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    @ObservedObject var colorPaletteCondition = ColorPalette()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("My Perfume Palette")
                        .font(.largeTitle)
                        .padding(.bottom, 40)
                        .fontWeight(.semibold)
                    
                    ZStack {
                        // MARK: - 팔레트 테두리 색
                        Group{
                            ForEach(Array(PerfumeColor.types.enumerated()), id: \.offset) { index, color in
                                PalletteCell(
                                    color: color.color,
                                    degrees: Double(index) * 22.5,
                                    name: color.name,
                                    count: scentTypeCount[color.name] ?? 0)
                                //                                .opacity(isTapped ? (color.name == txt ? 1 : 0.5) : 0.5)
                                .onTapGesture {
                                    colorPaletteCondition.selectedColor = color.color
                                    colorPaletteCondition.selectedCircle = color.color
                                    txt = color.name
                                    isTapped = true
                                    perfumes = perfumeStore.likedPerfumes.filter {$0.scentType == color.name}
                                }
                            }
                            .frame(width: 300, height: 300)
                        }
                        
                        // MARK: - 팔레트 눌렀을때 나오는 가운데 부분
                        ForEach(Array(PerfumeColor.types.enumerated()), id: \.offset) { index, color in
                            RoundedRectangle(cornerRadius: 20)
                                .fill(color.color)
                                .frame(width: 80, height: 80)
                                .overlay {
                                    Text("\(String(color.name))")
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                }
                                .opacity(isTapped ? (color.name == txt ? 1 : 0) : 0)
                                .animation(.linear(duration: 0.5), value: txt)
                                .onTapGesture {
                                    if isTapped {
                                        colorPaletteCondition.selectedColor = .clear
                                        colorPaletteCondition.selectedCircle = .clear
                                        txt = ""
                                        isTapped = false
                                        perfumes.removeAll()
                                    }
                                }
                        }
                    }
                    
                    //MARK: -Scent type
                    HStack {
                        Text("Scent Type")
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.top, 30)
                    
                    // scent type에 대한 설명
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus bibendum nulla libero, vel accumsan sapien blandit ac. Donec nunc ligula, imperdiet eu massa ac, vehicula faucibus neque.")
                        .padding()
                        .background(Color("customGray"))
                        .cornerRadius(10)
                    //                        .frame(height: 150)
                    
                    
                    //MARK: -Wish list
                    HStack {
                        Text("Wish List")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding(.top, 30)
                    
                    if userInfoStore.user != nil {
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(perfumes, id: \.self.perfumeId) { perfume in
                                NavigationLink {
                                    PerfumeDetailView(perfume: perfume)
                                } label: {
                                    PerfumeCell(perfume: perfume, frameWidth: 150)
                                }
                            }
                        }
                    } else {
                        Spacer()
                        Spacer()
                        HStack {
                            Spacer()
                            Image("love")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("If you sign in...")
                                    .padding(.bottom, 10)
                                Text("You can collect only your favorite products.")
                            }
                            .frame(width: 200)
                            Spacer()
                        }
                        .onTapGesture(perform: {
                            isSignin.toggle()
                        })
                        .alert(
                        """
                        If you want to use Liked / Comments,
                        Please sign in
                        """
                        ,isPresented: $isSignin
                        ) {
                            Button("Cancel", role: .cancel) {}
                            Button {
                                navLinkActive = true
                            } label: {
                                Text("Sign In")
                            }
                        }
                        
                    }
                }
                .padding()
                .zIndex(1)
            }
            .background(
                ZStack {
                    ColorPaletteUnderView(colorPaletteCondition: colorPaletteCondition, perfumesCount: perfumes.count)
                }
            )
            .modifier(SignInFullCover(isShowing: $navLinkActive))
            .padding(.top, 0.1)
            .onAppear {
                Task {
                    guard let userId = userInfoStore.user?.uid else {return}
                    await perfumeStore.readLikedPerfumes(userId: userId)
                    for perfume in perfumeStore.likedPerfumes {
                        scentTypeCount[perfume.scentType] = (scentTypeCount[perfume.scentType] ?? 0) + 1
                    }
                    perfumes = perfumeStore.likedPerfumes.filter {$0.scentType == txt}
                }
            }
            .onDisappear()
        }
    }
}

struct PaletteView_Previews: PreviewProvider {
    static var previews: some View {
        PaletteView()
            .environmentObject(UserInfoStore())
            .environmentObject(PerfumeStore())
    }
}
