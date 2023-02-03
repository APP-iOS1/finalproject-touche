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
    
    @State private var searchText = ""
    @State private var showingDeleteAlert = false
    @FocusState private var focusField : Field?
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    //    let testItem: [String] = ["Jo Malone London", "Jasmine", "Dior", "CHANCE EAU TENDRE Eau de Toilette", "Yves Saint Laurent","Jo Malone London", "Jasmine", "Dior", "CHANCE EAU TENDRE Eau de Toilette", "Yves Saint Laurent"]
    
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
            .padding([.leading, .trailing])
            .padding(.top, -7)
            .onAppear{
                focusField = .searchText
            }
        }// Vstack 종료
        .overlay(content: {
            Text(searchResults.isEmpty ? "최근에 검색하신 글이 없어요! 🥹😅" : "")
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
        }
        //        .toolbar(content: {
        //            ToolbarItem {
        //                HStack {
        //                    TextField("Search products, brands or notes", text: $searchText)
        //                        .focused($focusField, equals: .searchText)
        //                        .keyboardType(.alphabet)
        //                        .autocorrectionDisabled()
        //                        .textInputAutocapitalization(.never)    // 첫 영문자 대문자로 시작 막음
        //                    Spacer(minLength: 0)
        //
        //                    if !searchText.isEmpty {
        //                        Button {
        //                            self.searchText = ""
        //                        } label: {
        //                            Image(systemName: "xmark")
        //                                .resizable()
        //                                .foregroundColor(Color(UIColor.systemGray6))
        //                                .frame(width: 9, height: 9)
        //                                .background(Circle().foregroundColor(Color.black).frame(width: 16, height: 16))
        //                            //                                .padding(.trailing, 5)
        //                        }
        //                    }
        //
        //                    NavigationLink {
        ////                                                SearchResultView()
        //                    } label: {
        //                        //클릭시 검색, 텍스트 없을 경우 버튼 막기
        //                        Image(systemName: "magnifyingglass").foregroundColor(.black)
        //                    }.disabled(searchText.isEmpty)
        //                }
        //                .frame(width: 325)
        //                .padding(5)
        //                .background(.white)
        //                .cornerRadius(7)
        //                .overlay(
        //                    RoundedRectangle(cornerRadius: 7)
        //                        .stroke(lineWidth: 1)
        //                )
        //            }
        //        })
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
