//
//  SearchView.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/01/18.
//

import SwiftUI
import FirebaseFirestoreSwift

struct SearchView: View {
    enum Field: Hashable {
        case searchText
    }
    
    @EnvironmentObject var perfumeStore: PerfumeStore
    // 최근 검색어 UserDefaults
    @State var recentSearchesUD: [String] = UserDefaults.standard.array(forKey: "recentSearchesUD") as? [String] ?? [String]()
    // 키보드 검색 누르면, 다음화면으로 이동 (현재 미사용)
    @State private var isSearchActive = false
    // 검색창 Text
    @State private var searchText = ""
    // recentSearches 검색어 전체 삭제 알럿변수
    @State private var showingDeleteAlert = false
    // keyboard Focus field (현재 미사용)
    @FocusState private var focusField : Field?
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
//    @FirestoreQuery(collectionPath: "Perfume") var perfumes: [Perfume]
    var AllPerfumeNames: [String] = UserDefaults.standard.array(forKey: "NameOfAllPerfumes") as? [String] ?? [String]()
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return []
        } else {
            // brand name
            let brandNames = Brand.dummy.filter { brand in
                brand.name.lowercased().hasPrefix(searchText.lowercased())
                // perfume.displayName.lowercased().contains(searchText.lowercased())
            }
            .map { $0.name }
            
            // perfume name
            let perfumeNames = AllPerfumeNames.filter { name in
                name.lowercased().contains(searchText.lowercased())
            }
            .map { $0 }
            
            // all searches
            return brandNames + perfumeNames
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 20.0) {
                if !perfumeStore.recentSearches.isEmpty && searchText.isEmpty {
                    Text("RECENT SEARCHES")
                        .font(.callout)
                    ForEach(perfumeStore.recentSearches, id: \.self) { result in
                        HStack{
                            // Search
                            NavigationLink {
                                checkBrandNameOrDisplayName(text: result)
                                    .onAppear {
                                        stackSearchText(text: result)
                                    }
                            } label: {
                                // UI
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                    Text(result)
                                        .font(.system(size: 16))
                                        .lineLimit(1)
                                    Spacer()
                                }
                            }
                            // x button
                            Button {
                                if let index = perfumeStore.recentSearches.firstIndex(of: result) {
                                    perfumeStore.recentSearches.remove(at: index)
                                    UserDefaults.standard.set(perfumeStore.recentSearches, forKey: "recentSearchesUD")
                                }
                            } label: {
                                Image(systemName: "xmark")
                            }
                            .zIndex(100)
                        }
                        .foregroundStyle(.secondary)
                    }
                    
                    if !searchText.isEmpty && !searchResults.isEmpty { Divider() }
                }
                
                // 브랜드 검색 나타나는 부분
                Text(perfumeStore.isShowingBrandText && searchText != "" ? "brand" : "")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                ForEach(searchResults, id: \.self) { result in
                    if checkShowingNavigationLinkOfBrand(text: result) {
                        NavigationLink {
                            checkIsItBrand(text: result)
                                .onAppear {
                                    stackSearchText(text: result)
                                }
                        } label: {
                            HStack{
                                Image(systemName: "magnifyingglass")
                                Text(result)
                                    .font(.system(size: 16))
                                    .lineLimit(1)
                                Spacer()
                                Image(systemName: "arrow.up.right")
                                
                            }
                        }
                    }
                }
                
                // 이름 검색 나타나는 부분
                Text(perfumeStore.isShowingPerfumeText && searchText != "" ? "perfume" : "")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                ForEach(searchResults, id: \.self) { result in
                    if checkShowingNavigationLinkOfDisplayName(text: result) {
                        NavigationLink {
                            checkIsItDisplayName(text: result)
                                .onAppear {
                                    stackSearchText(text: result)
                                }
                        } label: {
                            HStack{
                                Image(systemName: "magnifyingglass")
                                Text(result)
                                    .font(.system(size: 16))
                                    .lineLimit(1)
                                Spacer()
                                Image(systemName: "arrow.up.right")
                                
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20.0)
            .padding(.vertical, 4.0)
        }
        //        .listStyle(.plain)
        .scrollDismissesKeyboard(.interactively)
        .tint(.primary)
        .overlay(content: {
            Text((perfumeStore.recentSearches.isEmpty && searchText == "") ? "No **recent search** history." : "")
        })
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $searchText,
            placement: SearchFieldPlacement.navigationBarDrawer(displayMode: .always),
            prompt: "Search products, brands"
        )
        .keyboardType(.alphabet)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)    // 첫 영문자 대문자로 시작 막음
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .foregroundColor(.black)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: 함수들 다른 파일로 옮길 예정
    func stackSearchText(text: String) {
        guard !perfumeStore.recentSearches.contains(text) else {
            perfumeStore.recentSearches.remove(at: perfumeStore.recentSearches.firstIndex(of: text)!)
            perfumeStore.recentSearches.insert(text, at: 0)
            UserDefaults.standard.set(perfumeStore.recentSearches, forKey: "recentSearchesUD")
            return
        }
        // 최근 검색어 개수 줄이기
        if perfumeStore.recentSearches.count > 4 {
            perfumeStore.recentSearches.removeLast()
            perfumeStore.recentSearches.insert(text, at: 0)
            UserDefaults.standard.set(perfumeStore.recentSearches, forKey: "recentSearchesUD")
        } else {
            perfumeStore.recentSearches.insert(text, at: 0)
            UserDefaults.standard.set(perfumeStore.recentSearches, forKey: "recentSearchesUD")
        }
    }
    
    func checkBrandNameOrDisplayName(text: String) -> FilteringResultView {
        for i in 0..<Brand.dummy.count {
            if Brand.dummy[i].name == text {
                Task { @MainActor in
                    perfumeStore.isShowingBrandText = true
                }
                return FilteringResultView(field: "brandName", queries: [text])
            }
        }
        Task { @MainActor in
            perfumeStore.isShowingPerfumeText = true
        }
        return FilteringResultView(field: "displayName", queries: [text])
    }
    
    func checkIsItBrand(text: String) -> FilteringResultView? {
        for i in 0..<Brand.dummy.count {
            if Brand.dummy[i].name == text {
                Task { @MainActor in
                    perfumeStore.isShowingBrandText = true
                }
                return FilteringResultView(field: "brandName", queries: [text])
            }
        }
        return nil
    }
    
    func checkIsItDisplayName(text: String) -> FilteringResultView? {
        for i in 0..<Brand.dummy.count {
            if Brand.dummy[i].name != text {
                Task { @MainActor in
                    perfumeStore.isShowingPerfumeText = true
                }
                return FilteringResultView(field: "displayName", queries: [text])
            }
        }
        return nil
    }
    
    func checkShowingNavigationLinkOfBrand(text: String) -> Bool {
        for brand in Brand.dummy {
            if brand.name == text {
                return true
            }
        }
        return false
    }
    
    func checkShowingNavigationLinkOfDisplayName(text: String) -> Bool {
        for brand in Brand.dummy {
            if brand.name == text {
                return false
            }
        }
        return true
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchView()
                .environmentObject(PerfumeStore())
        }
    }
}
