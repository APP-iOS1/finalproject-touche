//
//  Home.swift
//  Magazine
//
//  Created by TAEHYOUNG KIM on 2023/02/09.
//

import SwiftUI

/// https://www.youtube.com/watch?v=jwWfhM7ZuaI
/// https://www.youtube.com/watch?v=AjiLR9ORhzM
/// https://www.youtube.com/watch?v=J86h1mt5bio

struct MagazineView: View {
    @ObservedObject var perfumeStore: PerfumeStore = PerfumeStore()
    @Namespace var animation
    @State var currentItem: Magazine?
    @State var showDetailPage: Bool = false
    @State var animateView: Bool = false
    @State var animateContent: Bool = false
    @State var scrollOffset: CGFloat = 0
    @State var perfumes: [Perfume] = []
    @State private var scale: CGFloat = 1
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            Text("Magazine")
                .font(.largeTitle)
                .padding(.vertical, 15)
                .fontWeight(.semibold)
                .opacity(showDetailPage ? 0 : 1)
            
            VStack(spacing: 0) {
                ForEach(magazines) { item in
                    Button {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                            currentItem = item
                            showDetailPage.toggle()
                        }
                    } label: {
                        CardView(item: item)
                            .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.90)
                    }
                    .buttonStyle(ScaledButtonStyle())
                    .opacity(showDetailPage ? (currentItem?.id == item.id ? 1 :0) : 1)
                    
                }
            }
        }
        .overlay {
            if let currentItem = currentItem, showDetailPage {
                DetailView(item: currentItem)
                    .ignoresSafeArea(.container, edges: .top)
                
            }
        }
        .background(alignment: .top) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .frame(height: animateView ? nil : 350, alignment: .top)
                .scaleEffect(animateView ? 1: 0.93)
                .opacity(animateView ? 1 : 0)
                .ignoresSafeArea()
        }
    }
    @ViewBuilder
    func CardView(item: Magazine) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    Image(item.contentImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 20))
                }
                .frame(height: 400)
                
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.title).bold()
                
                Text(item.subTitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(
                Color.white
            )
            .clipShape(CustomCorner(corners: showDetailPage ? [] : [.bottomLeft, .bottomRight], radius: 20))
        }
        .shadow(color: .black.opacity(showDetailPage ? 0 : 0.3), radius: 20, x: 0, y: 10)
        .matchedGeometryEffect(id: item.id, in: animation)
    }
    
    func DetailView(item: Magazine) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CardView(item: item)
                    .scaleEffect(animateView ? 1 : 0.9)
//                    .gesture(
//
//                        DragGesture(minimumDistance: 0, coordinateSpace: .global)
//                            .onChanged { value in
//                                let endLocationY = value.location.y
//                                let startLocationY = value.startLocation.y
//                                let screenHeight = UIScreen.main.bounds.height
//                                let dragHeight = (endLocationY - startLocationY) / screenHeight
//                                    if scale > 0.7 {
//                                    scale = 1 - dragHeight
//                                    }
//                                print(dragHeight)
//                            }
//                            .onEnded { value in
//                                    if scale < 0.9 {
//                                    animateView.toggle()
//                                    }
//                                scale = 1
//                            }
//                    )
                VStack(spacing: 15) {
                    Image(item.bodyImage)
                        .resizable()
                        .scaledToFit()
                }
                .padding()
                .offset(y: scrollOffset > 0 ? scrollOffset : 0)
                .opacity(animateContent ? 1 : 0)
                .scaleEffect(animateView ? 1 : 0, anchor: .top)
                
                Text("Related product")
                    .font(.title2).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .leading], 15)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(perfumeStore.magazinePerfumes, id: \.self.perfumeId) { perfume in
                        NavigationLink {
                            PerfumeDetailView(perfume: perfume)
                        } label: {
                            PerfumeCell(perfume: perfume, frameWidth: 150)
                        }
                    }
                }
                .padding(.horizontal, 10)
                
                Spacer(minLength: 50)
                
            }
            .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            .offset(offset: $scrollOffset)
        }
//        .scaleEffect(scale)
        .overlay(alignment: .topTrailing, content: {
            Button {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                    animateView = false
                    animateContent = false
                }
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.05)){
                    currentItem = nil
                    showDetailPage = false
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .padding()
            .padding(.top, safeArea().top)
            .offset(y: -10)
            .opacity(animateView ? 1 : 0)
            
        })
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                animateView = true
            }
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.1)){
                animateContent = true
            }
            Task {
                await perfumeStore.readMagazinePerfumes(perfumesId: item.perfumeIds)
            }
        }
        .transition(.identity)
        
    }
}

struct MagazineView_Previews: PreviewProvider {
    static var previews: some View {
        MagazineView()
    }
}

struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeOut, value: configuration.isPressed)
    }
}

extension View {
    func safeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
    func offset(offset: Binding<CGFloat>) -> some View {
        return self
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                }
            }
            .onPreferenceChange(OffsetKey.self) { value in
                offset.wrappedValue = value
            }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
