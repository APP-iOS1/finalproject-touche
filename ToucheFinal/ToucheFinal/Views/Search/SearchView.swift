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
    // 키보드 검색 누르면, 다음화면으로 이동
    @State private var isSearchActive = false
    // 검색창 Text
    @State private var searchText = ""
    // recentSearches 검색어 전체 삭제 알럿변수
    @State private var showingDeleteAlert = false
    // keyboard Focus field
    @FocusState private var focusField : Field?
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @FirestoreQuery(collectionPath: "Perfume") var perfumes: [Perfume]
    
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
            let perfumeNames = perfumeNamesStore.filter { name in
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
                        .foregroundStyle(.secondary)
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
                                    Spacer()
                                }
                            }
                            // x button
                            Button {
                                if let index = perfumeStore.recentSearches.firstIndex(of: result) {
                                    perfumeStore.recentSearches.remove(at: index)
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
                
                ForEach(searchResults, id: \.self) { result in
                    NavigationLink {
                        checkBrandNameOrDisplayName(text: result)
                            .onAppear {
                                stackSearchText(text: result)
                            }
                    } label: {
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Text(result)
                                .font(.system(size: 16))
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                
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
            Text((perfumeStore.recentSearches.isEmpty && perfumeStore.recentSearches.isEmpty) ? "No **recent search word** history." : "")
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
                return FilteringResultView(field: "brandName", queries: [text])
            }
        }
        return FilteringResultView(field: "displayName", queries: [text])
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchView()
        }
    }
}

let perfumeNamesStore = ["Light Blue Eau de Toilette", "COCO MADEMOISELLE Eau de Parfum", "CHANCE Eau de Parfum", "Bright Crystal", "Daisy", "Flowerbomb", "Chloé Eau de Parfum", "CHANCE EAU FRAÎCHE Eau de Toilette", "CHANCE EAU TENDRE Eau de Toilette", "CHANCE Eau de Toilette", "CANDY Eau de Parfum", "’REPLICA’ Jazz Club", "’REPLICA’ Beach Walk", "Miss Dior Blooming Bouquet", "COCO NOIR", "Tobacco Vanille", "Oud Wood", "Black Opium Eau de Parfum", "Not A Perfume", "’REPLICA’ By the Fireplace", "Soleil Blanc Shimmering Body Oil", "Mon Paris Eau de Parfum", "Miss Dior Absolutely Blooming", "N°5 L’EAU", "Mon Guerlain Eau de Parfum", "Wood Sage & Sea Salt Cologne", "English Pear & Freesia Cologne", "Peony & Blush Suede Cologne", "Nectarine Blossom & Honey Cologne", "Oud & Bergamot Cologne Intense", "Light Blue Eau Intense", "Good Girl Eau de Parfum", "Bloom Eau de Parfum For Her", "GABRIELLE CHANEL Eau de Parfum", "’REPLICA’ Sailing Day", "Nomade Eau de Parfum", "Vanilla Woods Eau de Parfum", "Flowerbomb Nectar", "Fucking Fabulous", "Love, Don\'t Be Shy", "Black Phantom - \"Memento Mori\"", "Good Girl Gone Bad by KILIAN", "COCO MADEMOISELLE Eau de Parfum Intense", "Dolce Garden", "Dylan Blue Pour Femme", "Daisy Love Eau de Toilette", "No.04 Bois de Balincourt Eau de Parfum", "No.04 Bois de Balincourt Perfume Oil", "Ombré Leather Eau de Parfum", "Princess Eau de Parfum", "Lost Cherry", "Melrose Place Eau De Parfum", "North Bondi Eau De Parfum", "Rosie Perfume Oil", "Her Eau de Parfum", "Good Girl Eau de Parfum Légère", "VANILLA | 28", "Chance Eau Tendre Eau de Parfum", "\'REPLICA\' Under the Lemon Trees", "Wild Poppy Eau de Parfum", "Miss Dior Eau de Toilette", "Guilty Pour Femme Eau de Parfum", "Daisy Love Eau So Sweet", "Vanilla Vibes", "Her Blossom Eau de Toilette", "Libre Eau De Parfum", "Idôle Eau de Parfum", "Hypnotic Poison", "Donna Born In Roma Eau de Parfum", "GABRIELLE CHANEL ESSENCE Eau de Parfum", "Soleil Neige", "Rolling in Love", "Miss Dior Rose N\'Roses Eau de Toilette", "\'REPLICA\' Springtime In A Park Eau de Toilette", "Rose Prick", "Ocean di Gioia Eau de Parfum", "Not A Perfume Superdose", "Irresistible Eau de Parfum", "Good Girl Eau de Parfum Supreme", "Perfect Eau de Parfum", "Black Orchid Parfum", "Bloom Profumo di Fiori Eau de Parfum", "\'REPLICA\' Coffee Break Eau de Toilette", "My Way Eau de Parfum", "COCO MADEMOISELLE L’EAU PRIVÉE Eau Pour la Nuit", "Voce Viva Eau de Parfum", "LIBRE Eau de Parfum Intense", "Bitter Peach Eau De Parfum", "Angels Share Eau De Parfum", "Roses On Ice Eau De Parfum", "\'REPLICA\' Bubble Bath", "Vanilla Sky Eau de Parfum", "Scarlet Poppy Cologne Intense", "Santal Vanille Eau de Parfum", "Dylan Turquoise Pour Femme", "Donna Born in Roma Yellow Dream Eau de Parfum", "Libre Eau de Toilette", "PEAR INC.", "Madagascar Vanilla Perfume Oil", "Madagascar Vanilla Perfume Oil Rollerball", "Soleil Brulant", "Daisy Eau So Intense Eau de Parfum", "REPLICA\' Matcha Meditation", "UTOPIA VANILLA COCO | 21", "Very Good Girl Eau de Parfum", "Flora Gorgeous Gardenia Eau de Parfum", "INVITE ONLY AMBER | 23", "Miss Dior Eau de Parfum", "Perfect Intense Eau de Parfum", "Ombré Leather Parfum", "Sunflower Pop Eau De Parfum", "Alien Goddess Eau de Parfum", "Vanilla Sky Perfume Set", "Apple Brandy Eau de Parfum", "Mini Soleil Neige Shimmering Body Oil", "Ébène Fumé Eau de Parfum", "Flowerbomb Ruby Orchid Eau de Parfum", "\'REPLICA\' When the Rain Stops", "Black Opium Illicit Green Eau de Parfum", "Her Eau De Toilette", "Born in Roma Coral Fantasy Eau de Parfum", "Missing Person Eau de Parfum"]
