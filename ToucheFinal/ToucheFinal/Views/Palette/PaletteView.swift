//
//  TESTVIEWTS.swift
//  ToucheFinal
//
//  Created by 김태성 on 2023/01/31.
//

import SwiftUI

struct PaletteView: View {
    @EnvironmentObject var perfumeStore: PerfumeStore
    @EnvironmentObject var userInfoStore: UserInfoStore
    
    @State private var selectedColor: Color = .clear
    @State private var perfumes: [Perfume] = []
    @State private var scentTypeCount: [String: Double] = [:]
    @State private var rotationDegrees: Double = 0
    @State private var selectedScentType = ""
    @State private var isTapped = false
    @State private var isSignin = false
    @State private var navLinkActive = false
    
    var userSelectedScentType: [String] = UserDefaults.standard.array(forKey: "selectedScentTypes") as? [String] ?? []
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Perfume Palette")
                        .font(.largeTitle)
                        .padding(.bottom, 40)
                        .fontWeight(.semibold)
                    
                    ZStack {
                        // MARK: - 팔레트 테두리 색
                        Group{
                            ForEach(Array(PerfumeColor.types.enumerated()), id: \.offset) { index, color in
                                PaletteCell(
                                    selectedColor: selectedColor, color: color.color,
                                    degrees: Double(index) * 22.5,
                                    name: color.name,
                                    count: scentTypeCount[color.name] ?? 0)
                                .onTapGesture {
                                    selectedColor = color.color
                                    selectedScentType = color.name
                                    isTapped = true
                                    perfumes = perfumeStore.likedPerfumes.filter {$0.scentType == color.name}
                                    rotationDegrees = Double(index) * 22.5
                                }
                            }
                        }
                        .frame(width: 300, height: 300)
                        .padding(.vertical, 20)
                        .rotationEffect(Angle(degrees: 360 - rotationDegrees))
                        .animation(.easeInOut(duration: 1), value: rotationDegrees)
                        
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
                                .opacity(isTapped ? (color.name == selectedScentType ? 1 : 0) : 0)
                                .animation(.linear(duration: 0.5), value: selectedScentType)
                        }
                    }
                    
                    //MARK: -Scent type
                    if selectedScentType != "" {
                        HStack {
                            Text(selectedScentType)
                                .minimumScaleFactor(0.7)
                                .font(.title)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                            if userSelectedScentType.contains(selectedScentType) {
                                Text("(\(Image(systemName: "checkmark")))")
                                    .bold()
                            }
                            Spacer()
                        }
                        .padding(.top, 30)
                        
                        // scent type에 대한 설명
                        Text(PerfumeColor.types.filter{$0.name == selectedScentType}.first?.description?.first ?? " ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(.white)
                            .cornerRadius(10)
                    }
                    
                    //MARK: -Wish list
                    HStack {
                        Text("Liked")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding(.top, 30)
                    
                    if userInfoStore.user?.isEmailVerified ?? false {
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
                                Text("To use more features")
                                    .padding(.bottom, 10)
                                Text("You can collect your favorite products.")
                            }
                            .frame(width: 200)
                            Spacer()
                        }
                        .padding(.bottom, 20)
                        .onTapGesture(perform: {
                            isSignin.toggle()
                        })
                        .alert(
                        """
                        Please sign in to like / comment on products
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
                    ColorPaletteUnderView(selectedColor: selectedColor, perfumesCount: perfumes.count)
                }
            )
            .modifier(SignInFullCover(isShowing: $navLinkActive))
            .padding(.top, 0.1)
            .onAppear {
                Task {
                    if let userId = userInfoStore.user?.uid {
                        await perfumeStore.readLikedPerfumes(userId: userId)
                        if perfumeStore.likedPerfumes.isEmpty {
                            guard let randomScentType = userSelectedScentType.randomElement() else {return}
                            setMaxCountScentType(scentType: randomScentType)
                        } else {
                            for perfume in perfumeStore.likedPerfumes {
                                scentTypeCount[perfume.scentType] = (scentTypeCount[perfume.scentType] ?? 0) + 1
                            }
                            if let mostWishScentType = scentTypeCount.max(by: { $0.value < $1.value}) {
                                setMaxCountScentType(scentType: mostWishScentType.key)
                            }
                        }
                    } else {
                        guard let randomScentType = userSelectedScentType.randomElement() else {return}
                        setMaxCountScentType(scentType: randomScentType)
                    }
                }
            }
        }
    }
    
    func setMaxCountScentType(scentType: String) {
        perfumes = perfumeStore.likedPerfumes.filter{$0.scentType == scentType}
        selectedColor = Color(scentType: scentType)
        selectedScentType = scentType
        isTapped = true
        if let colorPaletteCondition = PerfumeColor.types.firstIndex(where: {
            $0.name == scentType
        }) {
            rotationDegrees = Double(colorPaletteCondition) * 22.5
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
