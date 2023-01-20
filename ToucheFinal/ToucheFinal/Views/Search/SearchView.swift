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
    let testItem: [String] = ["Jo Malone London", "Jasmine", "Dior", "CHANCE EAU TENDRE Eau de Toilette", "Yves Saint Laurent","Jo Malone London", "Jasmine", "Dior", "CHANCE EAU TENDRE Eau de Toilette", "Yves Saint Laurent"]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("RECENT SEARCHES")
                        .bold()
                    Spacer()
                    Button {
                        // 최근 검색어(Search history or Recent Searches) 전체 삭제 버튼
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
                
                ScrollView(showsIndicators: false) {
                    // TODO: 검색 내역이 없는 경우 텍스트입력하기 (쿠팡참고) + 아래 빈 화면들 (어떤 검색어로 검색할 수 있는지 설명 Or 컬러 활용한 애니메이션 효과 )
                    VStack(alignment: .leading) {
                        ForEach(testItem, id: \.self) { item in
                            HStack {
                                NavigationLink {
                                    // 해당 텍스트에 대한 검색창 나오게 하기 ?
                                } label: {
                                    Text(item)
                                        .foregroundColor(.black)
                                        .frame(alignment: .leading)
                                    //                                        .padding(.bottom, 5)
                                        .font(.callout)
                                    //                                        .background(Color.brown)
                                }
                                
                                Spacer()
                                Button {
                                    // 해당 텍스트만 삭제
                                } label: {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .foregroundColor(Color(UIColor.systemGray2))
                                        .frame(width: 10, height: 10)
                                    //                                        .padding(.bottom, 10)
                                    //                                        .background()
                                }
                            }
                        }
                    }
                }
                .padding([.leading, .trailing])
                .padding(.top, -7)
                .onAppear{
                    focusField = .searchText
                    //                        vm.fetchUsersCurrentSearch()
                }
            }
        }
        .toolbar(content: {
            ToolbarItem {
                HStack {
                    TextField("Search products, brands or notes", text: $searchText)
                        .focused($focusField, equals: .searchText)
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
                                .frame(width: 9, height: 9)
                                .background(Circle().foregroundColor(Color.black).frame(width: 16, height: 16))
                            //                                .padding(.trailing, 5)
                        }
                    }
                    
                    NavigationLink {
//                                                SearchResultView()
                    } label: {
                        //클릭시 검색, 텍스트 없을 경우 버튼 막기
                        Image(systemName: "magnifyingglass").foregroundColor(.black)
                    }.disabled(searchText.isEmpty)
                }
                .frame(width: 325)
                .padding(5)
                .background(.white)
                .cornerRadius(7)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(lineWidth: 1)
                )
            }
        })
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
