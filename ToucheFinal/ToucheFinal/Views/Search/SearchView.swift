//
//  SearchView.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/01/18.
//

import SwiftUI

struct SearchView: View {
    enum Field: Hashable {
        case searchText
    }
    
    // 최근 기록 저장 변수
    @State private var recentSearches: [String] = []
    // firestore query
    // @State private var queryText = ""
    // 키보드 검색 누르면, 다음화면으로 이동
    @State private var isSearchActive = false
    // 검색창 Text
    @State private var searchText = ""
    // recentSearches 검색어 전체 삭제 알럿변수
    @State private var showingDeleteAlert = false
    // keyboard Focus field
    @FocusState private var focusField : Field?
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return []
        } else {
            return Brand.dummy.filter { brand in
                brand.name.lowercased().hasPrefix(searchText.lowercased())
                // perfume.displayName.lowercased().contains(searchText.lowercased())
            }
            .map { $0.name }
        }
    }
    
    /*
     1. recentSearch 배열이 비어있다 -> Recent Searches Text 안나옴, No recent search 문구 나옴
     
     */
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 20.0) {
                if !recentSearches.isEmpty && searchText.isEmpty {
                    Text("RECENT SEARCHES")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    ForEach(recentSearches, id: \.self) { result in
                        HStack{
                            // Search
                            NavigationLink {
                                FilteringResultView(field: "brandName", queries: [result])
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
                
                ForEach(searchResults, id: \.self) { result in
                    NavigationLink {
                        FilteringResultView(field: "brandName", queries: [result])
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
            //        List {
            //            if !recentSearches.isEmpty && searchText.isEmpty{
            //                Section("RECENT SEARCHES") {
            //                    ForEach(recentSearches, id: \.self) { result in
            //                        HStack{
            //                            ZStack(alignment: .leading) {
            //                                // Search
            //                                NavigationLink {
            //                                    FilteringResultView(field: "brandName", queries: [result])
            //                                        .onAppear {
            //                                            stackSearchText(text: result)
            //                                        }
            //                                } label: {
            //                                    EmptyView()
            //                                }
            //                                .opacity(0)
            //
            //                                // UI
            //                                HStack {
            //                                    Image(systemName: "magnifyingglass")
            //                                    Text(result)
            //                                        .font(.system(size: 18))
            //                                }
            //                            }
            //
            //                            // 일단 이거 푸쉬할테니까 다같이 풀어볼까요??
            //                            // 네네 저한테 시간 소요가 많아서.ㅜ
            //                            // x button
            //                            Button {
            //                                if let index = recentSearches.firstIndex(of: result) {
            //                                    recentSearches.remove(at: index)
            //                                }
            //                            } label: {
            //                                Image(systemName: "xmark")
            //                            }
            //                            .zIndex(100)
            //                        }
            //                    }
            //                    .listRowSeparator(.hidden)
            //                    .foregroundStyle(.secondary)
            //                }
            //                if !searchText.isEmpty && !searchResults.isEmpty { Divider() }
            //            }
            //
            //            ForEach(searchResults, id: \.self) { result in
            //                ZStack(alignment: .leading) {
            //                    NavigationLink {
            //                        FilteringResultView(field: "brandName", queries: [result])
            //                            .onAppear {
            //                                stackSearchText(text: result)
            //                            }
            //
            //                    } label: {
            //                        EmptyView()
            //                    }
            //                    .opacity(0)
            //
            //                    HStack{
            //                        Image(systemName: "magnifyingglass")
            //                        Text(result)
            //                            .font(.system(size: 18))
            //                            .foregroundColor(.primary)
            //                        Spacer()
            //                        Image(systemName: "arrow.up.right")
            //                            .foregroundColor(Color(UIColor.systemGray2))
            //                    }
            //                }
            //            }
            //            .listRowSeparator(.hidden)
        }
        //        .listStyle(.plain)
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
    func stackSearchText(text: String) {
        guard !recentSearches.contains(text) else {
            recentSearches.remove(at: recentSearches.firstIndex(of: text)!)
            recentSearches.insert(text, at: 0)
            return
        }
        // 최근 검색어 개수 줄이기
        if recentSearches.count > 4 {
            recentSearches.removeLast()
            recentSearches.insert(text, at: 0)
        } else {
            recentSearches.insert(text, at: 0)
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
