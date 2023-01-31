//
//  SearchFilterView.swift
//  ToucheFinal
//
//  Created by 조운상 on 2023/01/18.
//

import SwiftUI

struct Brand: Hashable, Identifiable {
    var id = UUID().uuidString
    var name: String
    var isSelected: Bool
    
    static var dummy: [Brand] = [
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
}

struct ColorSet: Hashable {
    var name: Color
    var description: [String]
    var isSelected: Bool
}

struct FragType: Hashable {
    var name: String
    var isSelected: Bool
}

class BrandStore: ObservableObject {
    @Published var brands: [Brand] = [
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
}

class ColorSetStore: ObservableObject {
    @Published var colors: [ColorSet] = [
        ColorSet(name: Color(.red), description: ["정렬적인", "섹시한", "성숙한"], isSelected: false),
        ColorSet(name: Color(.orange), description: ["오렌지", "시트러스", "상큼한"], isSelected: false),
        ColorSet(name: Color(.yellow), description: ["소근소근", "미모사", "오스만투스"], isSelected: false),
        ColorSet(name: Color(.green), description: ["푸릇한", "숲내음", "이끼", "바질"], isSelected: false),
        ColorSet(name: Color(.blue), description: ["평온한", "바다", "물내음"], isSelected: false),
        ColorSet(name: Color(.purple), description: ["신비로운", "샴푸향", "라일락"], isSelected: false),
        ColorSet(name: Color(.brown), description: ["우디", "편안함", "달콤함", "자상한"], isSelected: false),
        ColorSet(name: Color(.lightGray), description: ["머스크", "살내음", "포근한"], isSelected: false)
    ]
}

class FragTypeStore: ObservableObject {
    @Published var fragTypes: [FragType] = [
        FragType(name: "Fruity Florals", isSelected: false),
        FragType(name: "Warm & Sweet Gourmands", isSelected: false),
        FragType(name: "Warm Florals", isSelected: false),
        FragType(name: "Warm Woods", isSelected: false),
        FragType(name: "Fresh Florals", isSelected: false),
        FragType(name: "Fresh Citrus & Fruits", isSelected: false),
        FragType(name: "Classic Florals", isSelected: false),
        FragType(name: "Woody Spices", isSelected: false),
        FragType(name: "Cool Spices", isSelected: false),
        FragType(name: "Classic Woods", isSelected: false),
        FragType(name: "Citrus & Woods", isSelected: false),
        FragType(name: "Fresh Solar", isSelected: false),
        FragType(name: "Warm & Sheer", isSelected: false),
        FragType(name: "Powdery Florals", isSelected: false),
        FragType(name: "Fresh Aquatics", isSelected: false),
        FragType(name: "Earthy Greens & Herbs", isSelected: false)
    ]
}

struct SearchFilterView: View {
    
    let AlphabetList = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T", "U", "V", "W", "X", "Y", "Z"]
    
    @StateObject var brandStore: BrandStore = BrandStore()
    @StateObject var colorSetStore: ColorSetStore = ColorSetStore()
    @StateObject var fragTypeStore: FragTypeStore = FragTypeStore()
    
    @State private var currentCategory: Category = .brand
    @State private var selectedBrands: [Brand] = []
    @State private var selectedColors: [ColorSet] = []
    @State private var selectedFrags: [FragType] = []
    
    enum Category {
        case brand, color, fragrance
    }
    
    var body: some View {
        VStack {
            
            //TODO: 필터 된 아이템 리스트 노출시켜야 함
            //체크 해제되면 해당 항목이 목록에서 빠지게 만드는 기능구현해야함
            VStack(spacing: 15) {
                ScrollView(.horizontal) {
                    HStack {
                        //TODO: 조건문 삽입하여 분기처리
                        Text("Brand:")
                            .bold()
                        
                        ForEach(checkDup(selectedBrands: selectedBrands), id:\.self) { brandName in
                            Text("\(brandName)")
                            
                            Button {
                               //MARK: 해당버튼을 눌렀을 때, 선택된 브랜드 배열에서 지워주는 로직이 들어가야 함
                                
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                            }
                        }
                        
                    }
                }
                .padding([.leading, .trailing], 15)
                
                Divider()
                
                ScrollView(.horizontal) {
                    //TODO: 조건문 삽입하여 분기처리
                    HStack {
                        Text("Color:")
                            .bold()
                        Text(brandStore.brands[0].name)
                        Text(brandStore.brands[0].name)
                        Text(brandStore.brands[0].name)
                        Text(brandStore.brands[0].name)
                        Text(brandStore.brands[0].name)
                        Text(brandStore.brands[0].name)
                        Text(brandStore.brands[0].name)
                    }
                }
                .padding([.leading, .trailing], 15)
                
                Divider()
                
                ScrollView(.horizontal) {
                    //TODO: 조건문 삽입하여 분기처리
                    HStack {
                        Text("Type:")
                            .bold()
                        Text(brandStore.brands[0].name)
                        Text(brandStore.brands[0].name)
                        Text(brandStore.brands[0].name)
                        Text(brandStore.brands[0].name)
                        Text(brandStore.brands[0].name)
                        Text(brandStore.brands[0].name)
                        Text(brandStore.brands[0].name)
                    }
                }
                .padding([.leading, .trailing], 15)
            }
            
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
                                    .bold()
                                Text("Brands")
                            }
                            Spacer()
                            Rectangle()
                                .fill(currentCategory == .brand ? Color.black : Color.clear)
                                .frame(width: 2, height: 40)
                        }
                        .frame(width: 65)
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
                                    .bold()
                                Text("Color")
                            }
                            Spacer()
                            Rectangle()
                                .fill(currentCategory == .color ? Color.black : Color.clear)
                                .frame(width: 2, height: 40)
                        }
                        .frame(width: 65)
                    }
                    
                    Spacer()
                    
                    //타입
                    Button(action: {
                        currentCategory = .fragrance
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("03")
                                    .bold()
                                Text("Fragrance")
                                Text("Type")
                            }
                            Spacer()
                            Rectangle()
                                .fill(currentCategory == .fragrance ? Color.black : Color.clear)
                                .frame(width: 2, height: 40)
                        }
                        .frame(width: 84)
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
                                ForEach(brandStore.brands.indices, id: \.self) { index in
                                    let currentBrand = brandStore.brands[index].name
                                    if alphabet == String(firstCharacter(brand: currentBrand)) {
                                        HStack {
                                            SelectedBrandButton(brandStore: brandStore, index: index)
                                            
                                            Text("\(currentBrand)")
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(.inset)
                        
                    } else if currentCategory == .color {
                        // TODO: 색상 리스트 구현
                        List(colorSetStore.colors.indices, id: \.self) { index in
                            
                            let currentColorSet = colorSetStore.colors[index]
                            
                            HStack {
                                
                                SelectedColorButton(colorSetStore: colorSetStore, index: index)
                                
                                Circle()
                                    .fill(currentColorSet.name)
                                    .frame(width: 30, height: 40)
                                
                                ForEach(currentColorSet.description.indices) { index in
                                    if index < currentColorSet.description.count - 1 {
                                        Text("\(currentColorSet.description[index]),")
                                    } else {
                                        Text("\(currentColorSet.description[index])")
                                    }
                                }
                                
                            }//HStack
                        }
                        .listStyle(.inset)
                        
                    } else {
                        List(fragTypeStore.fragTypes.indices, id: \.self) { index in
                            
                            let nowType = fragTypeStore.fragTypes[index].name
                            
                            HStack {
                                SelectedFragButton(fragTypeStore: fragTypeStore, index: index)
                                Text("\(nowType)")
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
                .cornerRadius(7)
                
                
                //TODO: 초기화와 적용하기 버튼 기능구현
                //                if 사용자가 필터에서 무엇인가를 클릭했을 때 {
                // 적용하기 버튼 -> 검색 결과
                NavigationLink {
                    //someActions
//                    FilteringResultView()
                } label: {
                    Text("적용하기")
                        .foregroundColor(.white)
                }
                .frame(width: 200, height: 50)
                .background(.black)
                .cornerRadius(7)
                //                }
            }
            .padding(.bottom)
        }
    }
    
    func SelectedBrandButton(brandStore: BrandStore, index: Int) -> some View {
        
        var buttonColor: Color {
            get {
                return brandStore.brands[index].isSelected ? .black : .clear
            }
        }
        
        return Button {
            brandStore.brands[index].isSelected.toggle()
            
            for brand in brandStore.brands {
                if brand.isSelected {
                    selectedBrands.append(brand)
                }
            }
            //MARK: 선택된 브랜드에서 지워주는 로직 추가해야함
        } label: {
            Label("Toggle Selected", systemImage: "checkmark")
                .labelStyle(.iconOnly)
                .foregroundColor(buttonColor)
        }
    }
    
    func checkDup(selectedBrands: [Brand]) -> [String] {
        var tempArr: [String] = []
        
        for brand in selectedBrands {
            let temp = brand.name
            tempArr.append(temp)
        }
        
        let set = Set(tempArr)
        return Array(set)
        
    }

}

//TODO: 각 탭에서 리스트 아이템 클릭시 체크마크 표시해 줄 함수 탭별로 따로 만들기
//->완
//매개변수로 목업데이터(배열)을 받을지 말지 고민해봐야 함
//->완
//TODO: 해당 기능을 이용하여 뷰 상단에 선택된 리스트 아이템 노출,
//필터링 조건 -> 모든 탭에 해당하는 아이템이 선택되지 않아도 검색이 되게 해야함
//해당 아이템을 기반으로 적용하기 기능 구현,
//초기화 기능 구현

//TODO: 탭에서 아이템 선택 -> 상단에 해당 아이템이름 노출
//선택된 아이템리스트를 그리는 뷰는 나중에 생각할 것
//어떤 로직으로 구현할지?
//isSelected기반으로 필터링? 버튼 클릭시마다 필터? 효율적인가?
//버튼을 따로 하나 만든다 -> 이미 초기화, 적용하기 버튼이 존재하기 때문에 더이상의 버튼은 아닌듯
//탭의 아이템을 클릭하면 isSelected프로퍼티 기반으로 true인 것만 배열에 담아주고
//해당 배열을 뷰에 텍스트형식으로 노출되게 만든다?
//x버튼을 누르면 지워지는 기능도 넣어야 함


struct SearchFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterView()
    }
}

func firstCharacter(brand: String) -> Character {
    let first: Character = brand[brand.startIndex]
    
    return first
}

//func SelectedBrandButton(brandStore: BrandStore, index: Int) -> some View {
//
//    var buttonColor: Color {
//        get {
//            return brandStore.brands[index].isSelected ? .black : .clear
//        }
//    }
//
//    return Button {
//        brandStore.brands[index].isSelected.toggle()
//
//        for brand in brandStore.brands {
//            if brand.isSelected {
//
//            }
//        }
//    } label: {
//        Label("Toggle Selected", systemImage: "checkmark")
//            .labelStyle(.iconOnly)
//            .foregroundColor(buttonColor)
//    }
//}

//MARK: 버튼별 체크마크 생성
func SelectedColorButton(colorSetStore: ColorSetStore, index: Int) -> some View {
    
    var buttonColor: Color {
        get {
            return colorSetStore.colors[index].isSelected ? .black : .clear
        }
    }
    
    return Button {
        colorSetStore.colors[index].isSelected.toggle()
    } label: {
        Label("Toggle Selected", systemImage: "checkmark")
            .labelStyle(.iconOnly)
            .foregroundColor(buttonColor)
    }
}

func SelectedFragButton(fragTypeStore: FragTypeStore, index: Int) -> some View {
    
    var buttonColor: Color {
        get {
            return fragTypeStore.fragTypes[index].isSelected ? .black : .clear
        }
    }
    
    return Button {
        fragTypeStore.fragTypes[index].isSelected.toggle()
    } label: {
        Label("Toggle Selected", systemImage: "checkmark")
            .labelStyle(.iconOnly)
            .foregroundColor(buttonColor)
    }
}

