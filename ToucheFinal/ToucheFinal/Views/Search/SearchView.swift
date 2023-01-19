//
//  SearchView.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/01/18.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let testItem: [String] = ["Jo Malone London", "Jasmine", "Dior", "CHANCE EAU TENDRE Eau de Toilette", "Yves Saint Laurent"]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("RECENT SEARCHES")
                    Spacer()
                    Button {
                        // 최근 검색어(Search history or Recent Searches) 전체 삭제 버튼
                    } label: {
                        Text("DELETE")
                            .foregroundColor(.black)
                    }
                }
                .padding()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
//                        NavigationLink {
//                            // TODO: 2.
//                        } label: {
//                            // TODO: - 최대 5개 보여주기 - 데이터 연결 후 하기
//                            //                            ForEach(Array(vm.usersCurrentSearch.enumerated()), id:\.offset){ index ,item in
//                            //                                //검색 시 최근검색어 쌓아주기(최대 5개, 이상 추가 시 오래된 검색어 삭제)
//                            //                                if index < 5{
//                            //                                    Text(item).modifier(roundRectangle)
//                            //                                }
//                            //
//                            //                            }
//                            Text("Jo Malone London")
//                                .foregroundColor(.black)
//                                .frame(alignment: .leading)
//
//
//                        }
                        ForEach(testItem, id: \.self) { item in
                            NavigationLink {
                                // 해당 텍스트에 대한 검색창 나오게 하기 ?
                            } label: {
                                Text(item)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 5)
                                    .font(.callout)
                                    
                                
                            }
                        }
//                        Divider()
                    }
                }
                .padding([.leading, .trailing])
                .padding(.top, -7)
                    .onAppear{
                        //                        vm.fetchUsersCurrentSearch()
                    }
            }
        }
        .toolbar(content: {
            ToolbarItem {
                HStack{
                    Image(systemName: "magnifyingglass").foregroundColor(.black)
                    TextField("Search products, brands or notes", text: $searchText)
                        .keyboardType(.alphabet)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)    // 첫 영문자 대문자로 시작 막음
                    Spacer(minLength: 0)
                    if !searchText.isEmpty {
                        Button {
                            self.searchText = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .foregroundColor(Color(UIColor.systemGray6))
                                .frame(width: 8, height: 8)
                                .background(Circle().foregroundColor(Color(UIColor.systemGray2)).frame(width: 16, height: 16))
                                .padding(.trailing, 5)
                        }
                        
                    }
                    
                }
                .frame(width: 320)
                .padding(7)
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(7)
            }
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.mode.wrappedValue.dismiss()
                } label:{
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
