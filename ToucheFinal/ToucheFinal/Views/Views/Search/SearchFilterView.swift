//
//  SearchFilterView.swift
//  ToucheFinal
//
//  Created by 조운상 on 2023/01/18.
//

import SwiftUI

struct Brand {
    var name: String
    var isSelected: Bool
}

struct SearchFilterView: View {
    
    let AlphabetList = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T", "U", "V", "W", "X", "Y", "Z"]
    
    @State private var brands: [Brand] = [
        Brand(name: "Carolina Herrera", isSelected: false),
        Brand(name: "CHANEL", isSelected: false),
        Brand(name: "Valentino", isSelected: false),
        Brand(name: "Yves Saint Laurent", isSelected: false),
        Brand(name: "Dior", isSelected: false),
        Brand(name: "BURBERRY", isSelected: false),
        Brand(name: "Viktor&Rolf", isSelected: false),
        Brand(name: "Gucci", isSelected: false),
        Brand(name: "Prada", isSelected: false),
        Brand(name: "Maison Margiela", isSelected: false),
        Brand(name: "Versace", isSelected: false),
        Brand(name: "TOM FORD", isSelected: false),
        Brand(name: "KAYALI", isSelected: false),
        Brand(name: "DOLCE GABBANA", isSelected: false),
        Brand(name: "PHLUR", isSelected: false),
        Brand(name: "TOCCA", isSelected: false),
        Brand(name: "Marc Jacobs Fragrances", isSelected: false),
        Brand(name: "KILIAN Paris", isSelected: false),
        Brand(name: "Juliette Has a Gun", isSelected: false),
        Brand(name: "Mugler", isSelected: false),
        Brand(name: "Chloé", isSelected: false),
        Brand(name: "rmani Beauty", isSelected: false),
        Brand(name: "Jo Malone London", isSelected: false),
        Brand(name: "The 7 Virtues", isSelected: false),
        Brand(name: "HERMÈS", isSelected: false),
        Brand(name: "Paco Rabanne", isSelected: false),
        Brand(name: "CLEAN RESERVE", isSelected: false),
        Brand(name: "NEST New York", isSelected: false),
        Brand(name: "OUAI", isSelected: false),
        Brand(name: "Boy Smells", isSelected: false),
        Brand(name: "Juicy Couture", isSelected: false),
        Brand(name: "Givenchy", isSelected: false),
        Brand(name: "Moroccanoil", isSelected: false),
        Brand(name: "Lancôme", isSelected: false),
        Brand(name: "DedCool", isSelected: false),
        Brand(name: "Maison Louis Marie", isSelected: false),
        Brand(name: "Commodity", isSelected: false),
        Brand(name: "Ellis Brooklyn", isSelected: false),
        Brand(name: "VOLUSPA", isSelected: false),
        Brand(name: "Maude", isSelected: false),
        Brand(name: "Azzaro", isSelected: false),
        Brand(name: "SKYLAR", isSelected: false),
        Brand(name: "Montblanc", isSelected: false),
        Brand(name: "By Rosie Jane", isSelected: false),
        Brand(name: "DEREK LAM 10 CROSBY", isSelected: false),
        Brand(name: "FORVR Mood", isSelected: false),
        Brand(name: "Fable Mane", isSelected: false),
        Brand(name: "Eight & Bob", isSelected: false),
        Brand(name: "BERDOUES", isSelected: false),
        Brand(name: "HERETIC", isSelected: false),
        Brand(name: "GUERLAIN", isSelected: false),
        Brand(name: "Ralph Lauren", isSelected: false),
        Brand(name: "Narciso Rodriguez", isSelected: false),
        Brand(name: "AERIN", isSelected: false),
        Brand(name: "Bon Parfumeur", isSelected: false),
        Brand(name: "Capri Blue", isSelected: false),
        Brand(name: "Ceremonia", isSelected: false),
        Brand(name: "World of Chris Collins", isSelected: false),
        Brand(name: "Overose", isSelected: false),
        Brand(name: "Floral Street", isSelected: false),
        Brand(name: "Calvin Klein", isSelected: false),
        Brand(name: "CLINIQUE", isSelected: false),
        Brand(name: "OTHERLAND", isSelected: false),
        Brand(name: "Acqua di Parma", isSelected: false),
        Brand(name: "Bobbi Brown", isSelected: false),
        Brand(name: "Slip", isSelected: false),
        Brand(name: "Jack Black", isSelected: false),
        Brand(name: "Vitruvi", isSelected: false),
        Brand(name: "ABBOTT", isSelected: false),
        Brand(name: "The Phluid Project", isSelected: false),
        Brand(name: "The Nue Co", isSelected: false),
        Brand(name: "Donna Karan", isSelected: false),
        Brand(name: "JIMMY CHOO", isSelected: false),
        Brand(name: "Dae", isSelected: false),
        Brand(name: "John Varvatos", isSelected: false),
        Brand(name: "Gisou", isSelected: false),
        Brand(name: "Atelier Cologne", isSelected: false),
        Brand(name: "Philosophy", isSelected: false),
        Brand(name: "KVD Beauty", isSelected: false),
    ]
    
    let fragranceType = [
        "Fruity Florals",
        "Warm & Sweet Gourmands",
        "Warm Florals",
        "Warm Woods",
        "Fresh Florals",
        "Fresh Citrus & Fruits",
        "Classic Florals",
        "Woody Spices",
        "Cool Spices",
        "Classic Woods",
        "Citrus & Woods",
        "Fresh Solar",
        "Warm & Sheer",
        "Powdery Florals",
        "Fresh Aquatics",
        "Earthy Greens & Herbs"
    ]
    
    @State private var currentCategory: Category = .brand
    @State private var selectedBrand: [String] = []
    
    enum Category {
        case brand, color, fragrance
    }
    
    var body: some View {
        VStack {
            // 페이지 상단의 필터링된 브랜드, 컬러를 보여주는 HStack
            
            //MARK: 필터링 된 브랜드명을 보여주는 뷰 + 필터링된 컬러를 보여주는 뷰
//            HStack {
                //TODO: 필터링 된 결과를 보여주는 뷰 추가해야함
//                VStack(alignment: .leading) {
//                    ScrollView {
//                        GridView()
//                            .frame(width: 300)
//                    }
//                }
                // TODO: 필터링 된 컬러를 보여줄 부분
//                VStack {
//                    ForEach(colorStore.colorInfoStore.indices, id: \.self) { idx in
//                        Button {
//                            colorStore.colorInfoStore[idx].isSelected = false
//                        } label: {
//                            if colorStore.colorInfoStore[idx].isSelected {
//                                HStack {
//                                    Circle()
//                                        .fill(Color(hex:colorStore.colorInfoStore[idx].color_hex))
//                                        .frame(width: 20, height: 20)
//                                    Image(systemName: "xmark")
//                                }
//                            }
//                        }
//                        .foregroundColor(.black)
//                    }
//                }
//                .frame(width: 50)
//            }
//            .frame(height: 100)
            
            Divider()
            
            
            //MARK: 브랜드,색상, 타입 선택 탭
            HStack {
                
                VStack(alignment: .leading) {
                    
                    //브랜드
                    Button(action: {
                        currentCategory = .brand
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("01")
                                Text("브랜드")
                            }
                            Spacer()
                            Rectangle()
                                .fill(currentCategory == .brand ? Color.black : Color.clear)
                                .frame(width: 2, height: 40)
                        }
                        .frame(width: 52)
                    }
                    .padding(.top, 25)
                    
                    Spacer()
                    
                    //색상
                    Button(action: {
                        currentCategory = .color
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("02")
                                Text("색상")
                            }
                            Spacer()
                            Rectangle()
                                .fill(currentCategory == .color ? Color.black : Color.clear)
                                .frame(width: 2, height: 40)
                        }
                        .frame(width: 52)
                    }
                    
                    Spacer()

                    //타입
                    Button(action: {
                        currentCategory = .fragrance
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("03")
                                Text("Fragrance Type")
                            }
                            Spacer()
                            Rectangle()
                                .fill(currentCategory == .fragrance ? Color.black : Color.clear)
                                .frame(width: 2, height: 40)
                        }
                        .frame(width: 52)
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .font(.callout)
                .padding(.leading, 10)
                .foregroundColor(.black)
                
                Spacer()
                
                //MARK: 브랜드, 색상, 프래그런스 타입
                VStack {
                    
                    if currentCategory == .brand {
                        // 브랜드 명
                        List (AlphabetList, id: \.self) { alphabet in
                            Section(header: Text("\(alphabet)")) {
                                ForEach(brands.indices, id: \.self) { idx in
                                    let nowBrand = brands[idx].name
                                    if alphabet == String(firstCharacter(brand: nowBrand)) {
                                        HStack {
//                                            SelectedButtonView(selectedBrand: $selectedBrand, idx: idx)
                                            SelectedButton(idx: idx)
                                            Text("\(nowBrand)")
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(.inset)
                    } else if currentCategory == .color {
                        // TODO: 색상 리스트 구현
//                        ScrollView{
//                            VStack(alignment: .leading, spacing: 15){
//                                ForEach(colorStore.colorInfoStore.indices, id: \.self) { idx in
//                                    SelectedColorButtonView(idx: idx)
//                                }
//                            }
//                        }.padding(.top, 50)
                        
                        //MARK: 임시로 프래그런스타입 넣어둠
                        List (fragranceType, id: \.self) { type in
                            HStack {
                                Text("\(type)")
                            }
                        }
                        .listStyle(.inset)
                        
                    } else if currentCategory == .fragrance {
                        List (fragranceType, id: \.self) { type in
                            HStack {
                                Text("\(type)")
                            }
                        }
                        .listStyle(.inset)
                    }
                    
                }.frame(width: 300)
            }
            
            // TODO: 초기화, 적용하기 버튼 로직 생성해야함
            HStack {

                // 브랜드, 컬러 초기화 버튼
                Button {
                   //some Actions
                } label: {
                    Label("초기화", systemImage: "arrow.clockwise")
                        .font(.callout)
                        .foregroundColor(.black)
                }
                .frame(width: 150, height: 50)
                .background(.gray.opacity(0.3))
                .cornerRadius(8)


                //TODO: 초기화와 적용하기 버튼 기능구현
//                if 사용자가 필터에서 무엇인가를 클릭했을 때 {
                    // 적용하기 버튼 -> 검색 결과
                    NavigationLink {
                        //someActions
                    } label: {
                        Text("적용하기")
                            .foregroundColor(.white)
                    }
                    .frame(width: 250, height: 50)
                    .background(.black)
                    .cornerRadius(8)
//                }
            }
        }
    }
    
    
    func SelectedButton(idx: Int) -> some View {
        
//        @Binding var selectedBrand: [String]
        
        //TODO: 선택 된 브랜드명을 반환해줄 로직이 필요함
        
        var buttonColor: Color {
            get {
                return brands[idx].isSelected ? .black : .clear
            }
        }
        
        
        return Button {
            brands[idx].isSelected.toggle()
            
//            selectedBrand.append(brands[idx].name)
        } label: {
            //나타나지도 않는 레이블을 쓰는 이유: 접근성 -> 청각장애인
            Label("Toggle Selected", systemImage: "checkmark")
                .labelStyle(.iconOnly)
                .foregroundColor(buttonColor)
        }
        
    }
    
}



struct SearchFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterView()
    }
}

func firstCharacter(brand: String) -> Character {
        let first: Character = brand[brand.startIndex]

        return first
    }



