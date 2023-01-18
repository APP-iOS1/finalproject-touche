//
//  SearchView.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/01/18.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    let testItem: [String] = ["Jo Malone London", "Jasmine", "Dior", "CHANCE EAU TENDRE Eau de Toilette", "Yves Saint Laurent"]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button {
                        //백버튼기능 (되려나?)
                    } label: {
                        Image(systemName: "chevron.left")
                            .padding(.leading)
                            .foregroundColor(.black)
                    }
                    
                    HStack{
                        Image(systemName: "magnifyingglass").foregroundColor(.black)
                        // TODO: - brandName, displayName, keyNotes 로 검색가능, placeholder명 뭐로 할 지
                        TextField("Search Brand, Notes, ", text: $searchText)
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
                            }
                            
                        }
                        
                    }.padding()
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(7)
                        .padding([.leading, .trailing], 10)
                }
                HStack{
                    Text("RECENT SEARCHES")
                    Spacer()
                    Button {
                        // 최근 검색어(Search history or Recent Searches) 전체 삭제 버튼
                    } label: {
                        Text("Delete")
                    }
                }
                .padding()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
//                        NavigationLink {
//                            // TODO: - 텍스트만 보이게? 아니면 해당 검색창으로 이동?
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
                                //
                            } label: {
                                Text(item)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom)
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
                
                Spacer()
                
                NavigationLink {
                    // 필터뷰로 이동
                } label: {
                    Text("Filters")
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                    //                        .padding()
                        .background(.black)
                        .cornerRadius(7)
                        .padding(.bottom)
                    
                }
                
                
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
