//
//  SearchView.swift
//  ToucheFinal
//
//  Created by 이재희 on 2023/01/18.
//

/*
 TODO
 [] 0. < 백버튼으로 사용가능한지
 [] 1. TextField: brandName,displayName,keyNotes로 검색가능, placeholder명 정하기
 [] 2. 최근 검색어 아래에 텍스트로만 보일지? 이미지도 같이 보여줄지?
 [] 2-1. 클릭시 해당 검색어 이동하게 할지
 [] 2-2. 최근 검색어 5개만 보이게하기, 데이터 연동
 [] 3. 필터뷰로 이동
 [] 4. 하루끝 참고해서 키보드 올라오는거 참고하기
 [] 5. DeleteAll, x 추가하기 -> x로 삭제 되고, 텍스트 누르면 검색창이동하듯 이동도 해야하는건지?
 */
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
                        Text("DeleteAll")
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
                                SearchFilterView()
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
                
                Spacer()
                
                NavigationLink {
//                    FilteringResultView()
                    SearchFilterView()
                } label: {
                    Text("Filters")
                        .foregroundColor(.white)
                        .frame(width: 130, height: 40)
                    //                        .padding()
                        .background(.black)
                        .cornerRadius(7)
                        .padding(.bottom)
                }
                
                
            }
        }
        .toolbar(content: {
            ToolbarItem {
                HStack{
                    Image(systemName: "magnifyingglass").foregroundColor(.black)
                    // TODO: 1.
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
                    
                }
                .frame(width: 320)
                .padding(11)
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(7)
                    .padding([.leading, .trailing], 10)
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
        .navigationTitle(Text("Filter"))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
