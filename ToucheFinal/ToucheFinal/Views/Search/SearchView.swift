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
            return dummy
        } else {
            return dummy.filter { perfume in
                perfume.brandName.lowercased().contains(searchText.lowercased())
                //                   perfume.displayName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack{
                Text("RECENT SEARCHES")
                    .bold()
                Spacer()
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
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .padding()
            
            // MARK: - 최근검색어(RECENT SEARCHES) 검색한 내용이 텍스트로 쌓이는 부분
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
                                Text(result.brandName)
                                    .foregroundColor(.black)
                                    .frame(alignment: .leading)
                                    .font(.callout)
                            }
                            Spacer()
                            Button {
                                // 해당 텍스트만 삭제 기능
                            } label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .foregroundColor(Color(UIColor.systemGray2))
                                    .frame(width: 10, height: 10)
                            }
                        }
                    }
                }
            }
            .padding([.leading, .trailing])
            .padding(.top, -7)
            .onAppear{
                focusField = .searchText
            }
        }
        
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
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
