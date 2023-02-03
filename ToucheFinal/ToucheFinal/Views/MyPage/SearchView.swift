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
    
    @State private var recentSearches: [String] = []
//    @State private var queryText = ""
    @State private var isSearchActive = false
    @State private var searchText = ""
    @State private var showingDeleteAlert = false
    @FocusState private var focusField : Field?
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
   
    let suggestions = ["Jo Malone London", "Jasmine", "Dior", "CHANCE EAU TENDRE Eau de Toilette", "Yves Saint Laurent", "CHANEL"]
    
    var searchResults: [Perfume] {
        if searchText.isEmpty {
            return []
        } else {
            return dummy.filter { perfume in
                perfume.brandName.lowercased().contains(searchText.lowercased())
                //                   perfume.displayName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack {

            // MARK: -

            HStack{
                Text(!searchText.isEmpty && !suggestions.filter { $0.hasPrefix(searchText) }.isEmpty ? "RECOMMEDED SEARCHES" : "RECENT SEARCHES")
                    .bold()
                Spacer()
                
                if recentSearches.isEmpty {
                    
                } else {
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
            .padding()
            
                        ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        //                        Text(searchText)
                        //                        ForEach(perfumeStore.recentlyViewed7Perfumes, id: \.self.perfumeId) { perfume in
                        ForEach(searchResults, id: \.perfumeId) { (result: Perfume) in
                            HStack {
                                NavigationLink {
                                    // 입력한 텍스트에 대한 검색결과뷰 나오게 하기
                                    SearchResultView(perfume: result, searchText: $searchText)
                                } label: {
                                    GeometryReader { geo in
                                        HStack{
                                                Text(result.brandName)
                                                    .font(.system(size: 18))
                                                    .foregroundColor(.black)
                                                    .offset(x: geo.size.width / 12)
                                            Spacer()
                                            Button {
                                                // 해당 텍스트만 삭제 기능
                                            } label: {
                                                Image(systemName: "arrow.up.right")
                                                    .foregroundColor(Color(UIColor.systemGray2))
                                                    
                                            }
                                            .padding(.trailing, 15)
                                        }
                                    }
                                    .padding(.top, 18)
                                }
                            }
                        }
                    }
            } // ScrollView 종료
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
        }// Vstack 종료
        .overlay(content: {
//            Text(recentSearches.isEmpty ? "최근에 검색하신 글이 없어요! 🥹😅" : "")
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
            
            // 최근 검색어 개수 줄이기
            if recentSearches.count > 5 {
                recentSearches.removeLast()
                recentSearches.insert(searchText, at: 0)
            } else {
                recentSearches.insert(searchText, at: 0)
            }
            
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
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
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
