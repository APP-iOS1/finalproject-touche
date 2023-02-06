//
//  SearchView.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/01/18.
//

import SwiftUI

/*
 - 광현
 1. 알파벳 입력 시 앞글자만 검색어 자동완성되도록 수정
 2. 서치 시 자동완성 검색어 뷰 수정
 
 - 유진
 3. Recent Searchs 에 최근 검색어 추가 (직접 검색했을 때, 키보드에서 검색 눌렀을 때 둘다 반영되는지 확인하기)
 4. 자동완성 검색어 프레임 조정 (누르면 위에 검색어가 검색되는 경우가 왕왕 있음)
 
 - 태성
 5.  알파벳 대문자, 소문자에서 상관없이 검색되도록 설정
 6. 동일한 검색어는 Recent Searchs 에 안쌓이도록 설정
 */
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
    
    var searchResults: [Brand] {
        if searchText.isEmpty {
            return []
        } else {
            return Brand.dummy.filter { brand in
                brand.name.lowercased().hasPrefix(searchText.lowercased())
                // perfume.displayName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack {
            if searchText.isEmpty {
                HStack{
                    Text("RECENT SEARCHES")
                        .bold()
                    Spacer()
                    
                    if !recentSearches.isEmpty {
                        
                        Button {
                            // 최근 검색어(Search history or Recent Searches) 전체 삭제 기능 - alert 후 전체 삭제
                            showingDeleteAlert = true
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.black)
                                .padding(.trailing, -4)
                        }
                        .alert(isPresented: $showingDeleteAlert) {
                            Alert(
                                title: Text("Are you sure you want to delete all?"),
                                message: Text("There is no undo"),
                                primaryButton: .destructive(Text("Delete")) {
                                    print("Deleting...")
                                    recentSearches.removeAll()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                }
                .padding(.horizontal, 20.0)
                .padding(.vertical, 8.0)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(searchResults) { (result: Brand) in
                        NavigationLink {
                            // 입력한 텍스트에 대한 검색결과뷰 나오게 하기
                            // SearchResultView(perfume: result, searchText: $searchText)
                            FilteringResultView(field: "brandName", queries: [result.name])
                        } label: {
                            HStack{
                                Image(systemName: "magnifyingglass")
                                Text(result.name)
                                    .font(.system(size: 18))
                                Spacer()
                                NavigationLink {
                                    // stackSearchText(text: result.name)
                                    FilteringResultView(field: "brandName", queries: [result.name])
                                } label: {
                                    Image(systemName: "arrow.up.right")
                                        .foregroundColor(Color(UIColor.systemGray2))
                                }
                            }
                        }
                        Divider()
                            .padding(.vertical, -8.0)
                    }
                }
                .tint(.primary)
                .padding(.horizontal, 20.0)
                .padding(.vertical, 16.0)
            } // ScrollView 종료
//            List {
//                ForEach(searchResults) { result in
//                    ZStack(alignment: .leading) {
//                        NavigationLink {
//                            FilteringResultView(field: "brandName", queries: [result.name])
//                        } label: {
//                            EmptyView()
//                        }
//                        .opacity(0)
//
//                        HStack{
//                            Image(systemName: "magnifyingglass")
//                            Text(result.name)
//                                .font(.system(size: 18))
//                                .foregroundColor(.black)
//                            Spacer()
//                            Image(systemName: "arrow.up.right")
//                                .foregroundColor(Color(UIColor.systemGray2))
//                        }
//                    }
//                    .listRowInsets(EdgeInsets(top: 0, leading: 45, bottom: 0, trailing: 60))
//                    .alignmentGuide(.listRowSeparatorTrailing) { viewDimensions in
//                        return viewDimensions[.listRowSeparatorTrailing] - 0
//                    }
//                }
//            }
//            .listRowSeparator(.hidden)
//            .accentColor(.white)
//            .listStyle(.plain)
            
            // MARK: - 추천 단어 표시 해주는 부분
            // if !searchText.isEmpty && !suggestions.filter { $0.hasPrefix(searchText) }.isEmpty {
            //     ScrollView(showsIndicators: false) {
            //         VStack(alignment: .leading) {
            //             ForEach(suggestions.filter { $0.hasPrefix(searchText) }, id: \.self) { suggestion in
            //                 HStack {
            //                     NavigationLink {
            //                         // 입력한 텍스트에 대한 검색결과뷰 나오게 하기
            //                         FilteringResultView(field: "brandName", queries: [suggestion])
            //                     } label: {
            //                         Text(suggestion)
            //                             .foregroundColor(.black)
            //                             .frame(alignment: .leading)
            //                             .font(.callout)
            //                     }
            //                     Spacer()
            //                     NavigationLink {
            //                         FilteringResultView(field: "brandName", queries: [suggestion])
            //                     } label: {
            //                         Image(systemName: "magnifyingglass")
            //                             .resizable()
            //                             .foregroundColor(Color(UIColor.systemGray2))
            //                             .frame(width: 10, height: 10)
            //                     }
            //                 }
            //             }
            //         }
            //     }
            //     .padding([.leading, .trailing])
            //     .padding(.top, -7)
            // }
            
            // MARK: - 최근검색어(RECENT SEARCHES) 검색한 내용이 텍스트로 쌓이는 부분
            if recentSearches.isEmpty {
                
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(recentSearches, id: \.self) { recentSearch in
                            HStack {
                                NavigationLink {
                                    // 입력한 텍스트에 대한 검색결과뷰 나오게 하기
                                    FilteringResultView(field: "brandName", queries: [recentSearch])
                                    
                                } label: {
                                    Text(recentSearch)
                                        .foregroundColor(.black)
                                        .frame(alignment: .leading)
                                        .font(.callout)
                                }
                                Spacer()
                                Button {
                                    // 해당 텍스트만 삭제 기능
                                    recentSearches.remove(at: recentSearches.firstIndex(of: recentSearch) ?? 0)
                                } label: {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .foregroundColor(Color(UIColor.systemGray2))
                                        .frame(width: 10, height: 10)
                                }
                            }
                        }
                    }
                    
                    // 키보드에서 Search 누르면 이동하는 뷰
                    NavigationLink(destination: FilteringResultView(field: "brandName", queries: [searchText]), isActive: $isSearchActive) {
                        EmptyView()
                    }
                    
                }
                
                .padding([.leading, .trailing])
                .padding(.top, -7)
                .onAppear{
                    focusField = .searchText
                }
            }
        }// Vstack 종료
        .overlay(content: {
            Text((recentSearches.isEmpty && searchText.isEmpty) ? "No **recent search word** history." : "")
        })
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $searchText,
            placement: SearchFieldPlacement.toolbar,
            prompt: "Search products, brands"
        )
        //            .focused($focusField, equals: .searchText)
        .keyboardType(.alphabet)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)    // 첫 영문자 대문자로 시작 막음
        .onSubmit(of: .search) {
            print("Search submitted")
            isSearchActive.toggle()
            //            queryText = searchText
            
            stackSearchText(text: searchText)
            
            //            searchText = ""
        }
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
    } // body
    
    func stackSearchText(text: String) {
        // 최근 검색어 개수 줄이기
        if recentSearches.count > 5 {
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
