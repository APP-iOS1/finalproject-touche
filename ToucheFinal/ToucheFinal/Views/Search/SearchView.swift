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
    
    // 최근 기록 저장 변수
    @State private var recentSearches: [SearchQuery] = []
    // 검색창 Text
    @State private var searchText = ""
    // keyboard Focus field
    @FocusState private var focusField : Field?
    // navigation dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    // =========================== TODO ===================================
    // 향수가 추가되거나 개수가 변동되었을때 읽기작업이 어떻게 변동이 될지?
    // 1. 온보딩 뷰에서 향수 이름들을 유저디폴트나 코어데이터에 저장해 둔다
    // 2. 서치 뷰에 들어갈때 마다 perfume 컬렉션 개수를 유저디폴트나  코어데이터에 저장된 향수 개수와 비교하여 변화가 있을경우 다시 업데이트하여 저장한다
    // ---------------------------------------------------------------------
    // 1. 로컬에 저장 -> 향수 이름 x , perfume 저장
    // 2. 로컬 저장 okay면, 서버 통신 필요없음 | 향수추가되면, 자동으로 업데이트해서 로컬에 저장
    // 3. 서버통신의 주요 사용은 '댓글 불러오기' 아닐까?
    @FirestoreQuery(collectionPath: "Perfume") var perfumes: [Perfume]
    // ====================================================================
    
    var searchResults: [SearchQuery] {
        if searchText.isEmpty {
            return []
        } else {
            // brands
            let brands = Brand.dummy.filter { brand in
                brand.name.lowercased().hasPrefix(searchText.lowercased())
            }
                .map { SearchQuery(category: .brand, query: $0.name) }
            
            // perfumes
            let perfumes = perfumes.filter { perfume in
                perfume.displayName.lowercased().contains(searchText.lowercased())
            }
                .map { SearchQuery(category: .perfume, query: $0.displayName) }
            
            // all searches
            return brands + perfumes
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 20.0) {
                // 최근 검색어
                if !recentSearches.isEmpty && searchText.isEmpty {
                    Text("SEARCH HISTORY")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    ForEach(recentSearches) { (result: SearchQuery) in
                        HStack{
                            // Search
                            NavigationLink {
                                FilteringResultView(
                                    field: result.category == .brand ? "brandName" : "displayName",
                                    queries: [result.query]
                                )
                                .onAppear {
                                    stackSearchText(result)
                                }
                            } label: {
                                // UI
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                    Text(result.query)
                                        .font(.system(size: 16))
                                        .lineLimit(1)
                                    Spacer()
                                }
                            }
                            // x button
                            Button {
                                if let index = recentSearches.firstIndex(of: result) {
                                    recentSearches.remove(at: index)
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
                
                // 검색어
                let perfumeIndex: Int = searchResults.filter { $0.category == .brand }.count
                ForEach(searchResults.indices, id: \.self) { (i: Int) in
                    switch i {
                    case 0:
                        Text(searchResults[i].category.rawValue)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    case perfumeIndex:
                        Text(searchResults[perfumeIndex].category.rawValue)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    default:
                        EmptyView()
                    }
                    NavigationLink {
                        FilteringResultView(
                            field: searchResults[i].category == .brand ? "brandName" : "displayName",
                            queries: [searchResults[i].query]
                        )
                        .onAppear {
                            stackSearchText(searchResults[i])
                        }
                    } label: {
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Text(searchResults[i].query)
                                .font(.system(size: 16))
                                .lineLimit(1)
                            Spacer()
                            Image(systemName: "arrow.up.right")
                            
                        }
                    }
                }
            }
            .padding(.horizontal, 20.0)
            .padding(.vertical, 4.0)
        }
        
        .scrollDismissesKeyboard(.interactively)
        .tint(.primary)
        .overlay(content: {
            Text((recentSearches.isEmpty && searchText.isEmpty) ? "No **recent search word** history." : "")
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
        .submitLabel(.done)
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
    func stackSearchText(_ searchQuery: SearchQuery) {
        guard !recentSearches.contains(searchQuery) else {
            recentSearches.remove(at: recentSearches.firstIndex(of: searchQuery)!)
            recentSearches.insert(searchQuery, at: 0)
            return
        }
        // 최근 검색어 개수 줄이기
        if recentSearches.count > 4 {
            recentSearches.removeLast()
            recentSearches.insert(searchQuery, at: 0)
        } else {
            recentSearches.insert(searchQuery, at: 0)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchView()
        }
    }
}

// MARK : 최근 검색어 텍스트 쌓기
//HStack{
//    Text("RECENT SEARCHES")
//        .bold()
//    Spacer()
//    Button {
//        // 최근 검색어(Search history or Recent Searches) 전체 삭제 기능 - alert 후 전체 삭제
//        showingDeleteAlert = true
//    } label: {
//        Image(systemName: "trash")
//            .foregroundColor(.black)
//            .padding(.trailing, -4)
//    }
//    .alert(isPresented: $showingDeleteAlert) {
//        Alert(
//            title: Text("Are you sure you want to delete all?"),
//            message: Text("There is no undo"),
//            primaryButton: .destructive(Text("Delete")) {
//                print("Deleting...")
//            },
//            secondaryButton: .cancel()
//        )
//    }
//}
//.padding()

//            if searchText.isEmpty {
//                HStack{
//                    Text("RECENT SEARCHES")
//                        .bold()
//                    Spacer()
//
//                    if !recentSearches.isEmpty {
//
//                        Button {
//                            // 최근 검색어(Search history or Recent Searches) 전체 삭제 기능 - alert 후 전체 삭제
//                            showingDeleteAlert = true
//                        } label: {
//                            Image(systemName: "trash")
//                                .foregroundColor(.black)
//                                .padding(.trailing, -4)
//                        }
//                        .alert(isPresented: $showingDeleteAlert) {
//                            Alert(
//                                title: Text("Are you sure you want to delete all?"),
//                                message: Text("There is no undo"),
//                                primaryButton: .destructive(Text("Delete")) {
//                                    print("Deleting...")
//                                    recentSearches.removeAll()
//                                },
//                                secondaryButton: .cancel()
//                            )
//                        }
//                    }
//                }
//                .padding(.horizontal, 20.0)
//                .padding(.vertical, 8.0)
//            }
//        ScrollView(showsIndicators: false) {
//            VStack(alignment: .leading) {
//                // recentSearch
//                Section("RECENT SEARCHES") {
//                    ForEach(recentSearches, id: \.self) { recentSearch in
//                        HStack {
//                            NavigationLink {
//                                // 입력한 텍스트에 대한 검색결과뷰 나오게 하기
//                                FilteringResultView(field: "brandName", queries: [recentSearch])
//
//                            } label: {
//                                Text(recentSearch)
//                                    .foregroundColor(.black)
//                                    .frame(alignment: .leading)
//                                    .font(.callout)
//                            }
//                            Spacer()
//                            Button {
//                                // 해당 텍스트만 삭제 기능
//                                recentSearches.remove(at: recentSearches.firstIndex(of: recentSearch) ?? 0)
//                            } label: {
//                                Image(systemName: "xmark")
//                                    .resizable()
//                                    .foregroundColor(Color(UIColor.systemGray2))
//                                    .frame(width: 10, height: 10)
//                            }
//                        }
//                    }
//                }
//                // search
//                ForEach(searchResults, id: \.self) { (result: String) in
//                    NavigationLink {
//                        // 입력한 텍스트에 대한 검색결과뷰 나오게 하기
//                        FilteringResultView(field: "brandName", queries: [result])
//                            .onDisappear {
//                                recentSearches.insert(result, at: 0)
//                            }
//                    } label: {
//                        HStack{
//                            Image(systemName: "magnifyingglass")
//                            Text(result)
//                                .font(.system(size: 18))
//                            Spacer()
//                            NavigationLink {
//                                // stackSearchText(text: result.name)
//                                FilteringResultView(field: "brandName", queries: [result])
//                            } label: {
//                                Image(systemName: "arrow.up.right")
//                                    .foregroundColor(Color(UIColor.systemGray2))
//                            }
//                        }
//                    }
//                    Divider()
//                        .padding(.vertical, -8.0)
//                }
//            }
//
//
//        }// Scroll 종료
