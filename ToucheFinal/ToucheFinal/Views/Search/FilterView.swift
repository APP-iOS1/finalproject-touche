//
//  FilterView.swift
//  ToucheFinal
//
//  Created by james seo on 2023/01/30.
//

import SwiftUI
import Combine

final class FilterViewModel: ObservableObject {
    @Published var brands: [Brand] = []
    @Published var colors: [PerfumeColor] = []
    @Published var canApplying: Bool = false
    @Published var tab: Tab = .brand
    @Published var search: String = ""

    // grouping: [https://www.hackingwithswift.com/forums/swift/best-way-to-group-string-array-by-first-character-and-show-in-table-view-as-groups/298](https://www.hackingwithswift.com/forums/swift/best-way-to-group-string-array-by-first-character-and-show-in-table-view-as-groups/298)
    
    var brandSections: [(letter: String, brands: [Brand])]  {
        let filtered = Brand.dummy.filter {
            if search.isEmpty {
                return true
            } else {
                return $0.name.lowercased().contains(search.lowercased())
            }
        }

        return Dictionary(grouping: filtered) { (brand) -> Character in
                return brand.name.first!
            }
        .map { (key: Character, value: [Brand]) -> (letter: String, brands: [Brand]) in
            (letter: String(key), brands: value)
        }
        .sorted { (left, right) -> Bool in
            left.letter < right.letter
        }
    }
    
    var colorSections: [(letter: String, colors: [PerfumeColor])]  {
        let filtered = PerfumeColor.types.filter {
            if search.isEmpty {
                return true
            } else {
                return $0.name.lowercased().contains(search.lowercased())
            }
        }

        return Dictionary(grouping: filtered) { (brand) -> Character in
                return brand.name.first!
            }
        .map { (key: Character, value: [PerfumeColor]) -> (letter: String, colors: [PerfumeColor]) in
            (letter: String(key), colors: value)
        }
        .sorted { (left, right) -> Bool in
            left.letter < right.letter
        }
    }
    
    enum Tab {
        case brand
        case color
    }
    
    init() {
        /// Apply버튼의 활성화여부를 자동적으로 갱신해줌.
        $brands
            .combineLatest($colors)
            .map { brands, colors -> Bool in
                return !brands.isEmpty || !colors.isEmpty
            }
            .assign(to: &$canApplying)
    }
    
    /// 이미 선택한 브랜드가 있는지 여부 파악
    func isSelectedBrand(_ brand: Brand) -> Bool {
        return brands.contains(brand)
    }
    
    /// 이미 선택한 컬러가 있는지 여부 파악
    func isSelectedColor(_ perfumeColor: PerfumeColor) -> Bool {
        return colors.contains(perfumeColor)
    }
    
    /// 선택한 브랜드 추가
    func appendBrand(_ brand: Brand) {
        brands.append(brand)
    }
    
    /// 선택한 브랜드 삭제
    func removeBrand(_ brand: Brand) {
        brands = brands.filter { $0.id != brand.id }
    }
    
    /// 선택한 컬러 추가
    func apppendColor(_ color: PerfumeColor) {
        colors.append(color)
    }
    
    /// 선택한 컬러 삭제
    func removeColor(_ color: PerfumeColor) {
        colors = colors.filter { $0.id != color.id }
    }
    
    /// Tab 바꾸기
    func toggleTab(_ tab: FilterViewModel.Tab) {
        self.tab = tab
        switch self.tab {
        case .brand:
            colors.removeAll()
            search = ""
        case .color:
            brands.removeAll()
            search = ""
        }
    }
    
    /// 전체 선택항목 삭제
    func clear() {
        brands.removeAll()
        colors.removeAll()
        search = ""
    }
}

struct FilterView: View {
    @StateObject var vm = FilterViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            // - HEADER
            filterHeaderView()
            // - BODY
            filterBodyView()
        }
        .padding(.top, 4.0)
        .padding(.bottom, vm.canApplying ? 40.0 + 30.0 : 0.0)
        // - BUTTON GROUP
        .overlay(alignment: .bottom, content: filterButtonGroupView)
        .overlay(alignment: .center) {
            Text((vm.brandSections.isEmpty || vm.colorSections.isEmpty) ? "No Results here.." : "")
                .foregroundStyle(.tertiary)
                .ignoresSafeArea(.keyboard)
        }
        .searchable(text: $vm.search, prompt: "Search")
        .scrollDismissesKeyboard(.interactively)
        .navigationBarTitle("Filter")
        .navigationBarTitleDisplayMode(.inline)
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

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}

/// FilterView의 세부 컴포넌트 뷰
private extension FilterView {
    /// FilterView의 HeaderView
    ///
    /// - Tab에 따라 brand 혹은 color를 선택했을때, 선택한 항목을 header에 나타내도록한다.
    /// - 선택된 항목을 누르면, 자동 삭제된다.
    func filterHeaderView() -> some View {
        Group {
            switch vm.tab {
            case .brand:
                // Brand
                HStack(alignment: .center) {
                    Text("Brand ")
                        .font(.headline)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(vm.brands, id: \.self) { brand in
                                
                                HStack {
                                    Text(brand.name)
                                        .fontWeight(.light)
                                    Image(systemName: "xmark")
                                }
                                .frame(height: 10)
                                .padding(10)
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .circular)
                                        .strokeBorder(.secondary, lineWidth: 0.5)
                                }
                                .padding(1)
                                .onTapGesture {
                                    vm.removeBrand(brand)
                                }
                            }
                        }
                    }
                }
                
                Divider()
                
            case .color:
                // Type
                HStack(alignment: .center) {
                    Text("Color")
                        .font(.headline)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(vm.colors, id: \.id) { perfumeColor in
                                HStack(spacing: 4.0) {
                                    Circle()
                                        .frame(width: 10)
                                        .foregroundColor(perfumeColor.color)
                                    Text(perfumeColor.name)
                                        .fontWeight(.light)
                                    Image(systemName: "xmark")
                                }
                                .frame(height: 10)
                                .padding(10)
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .circular)
                                        .strokeBorder(.secondary, lineWidth: 0.5)
                                }
                                .padding(1)
                                .onTapGesture {
                                    vm.removeColor(perfumeColor)
                                }
                            }
                        }
                    }
                }
                
                Divider()
            }
        }
        .frame(height: 30, alignment: .center)
        .padding(.horizontal, 16.0)
    }
    
    /// FilterView의 BodyView
    ///
    /// - Body는 크게 좌측으로 SelectionView와 ContentView로 구분한다.
    /// - Body뷰는 부모계층의 뷰다.
    func filterBodyView() -> some View {
        HStack(alignment: .top, spacing: 4.0) {
            filterSelectionView()
            
            filterContentView()
        }
    }
    
    /// Tab Selection View
    ///
    /// - 선택한 Tab에 따라, Header와 Content가 바뀐다.
    func filterSelectionView() -> some View {
        VStack(alignment: .leading, spacing: 32.0) {
            Text("**01**\nBrand")
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(alignment: .trailing) {
                    Rectangle()
                        .frame(width: 3)
                        .foregroundColor(vm.tab == .brand ? .primary : .clear)
                }
                .onTapGesture { vm.toggleTab(.brand) }
            
            Text("**02**\nColor")
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(alignment: .trailing) {
                    Rectangle()
                        .frame(width: 3)
                        .foregroundColor(vm.tab == .color ? .primary : .clear)
                }
                .onTapGesture { vm.toggleTab(.color) }
        }
        .frame(width: 60)
        .padding(.leading, 16.0)
    }
    
    /// ContentView
    ///
    /// - Tab에 따라 여러 컨텐츠를 구분해서 보여준다.
    /// - 컨텐츠를 선택하면, checkmark가 나타나고, 다시 선택하면 checkmark가 사라진다. 즉, 컨텐츠의 선택유무를 결정할 수 있다.
    func filterContentView() -> some View {
        Group {
            switch vm.tab {
            case .brand:
                ScrollViewReader { proxy in
                    List(vm.brandSections.indices, id: \.self) { index in
                        Section(vm.brandSections[index].letter) {
                            ForEach(vm.brandSections[index].brands) { brand in
                                Button {
                                    vm.isSelectedBrand(brand) ? vm.removeBrand(brand) : vm.appendBrand(brand)
                                } label: {
                                    HStack {
                                        Image(systemName: "checkmark")
                                            .opacity(vm.isSelectedBrand(brand) ? 1.0 : 0.0)
                                        Text(brand.name)
                                    }
                                }
                                .id(brand)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            case .color:
                ScrollViewReader { proxy in
                    List(vm.colorSections.indices, id: \.self) { index in
                        Section(vm.colorSections[index].letter) {
                            ForEach(vm.colorSections[index].colors) { color in
                                Button {
                                    vm.isSelectedColor(color) ? vm.removeColor(color) : vm.apppendColor(color)
                                } label: {
                                    HStack {
                                        Image(systemName: "checkmark")
                                            .opacity(vm.isSelectedColor(color) ? 1.0 : 0.0)
                                        Circle()
                                            .frame(width: 20)
                                            .foregroundColor(color.color)
                                        Text(color.name)
                                    }
                                }
                                .id(color)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
    
    /// FilterButtonGroup
    ///
    /// 1. **Clear**: 선택한 모든 항목들을 일괄 삭제한다.
    /// 2. **Apply**: 선택한 항목을 이용해서 필터링된 결과를 적용하는 버튼, 항목이 하나도 선택되지 않으면 버튼은 비활성화됨.
    func filterButtonGroupView() -> some View {
        HStack {
            Button {
                vm.clear()
            } label: {
                Text("Clear")
                    .frame(height: 40.0)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 20.0, style: .circular)
                            .strokeBorder(lineWidth: 1)
                            .background { Color.white }
                    }
            }
            .tint(.primary)
            
            NavigationLink {
                switch vm.tab {
                case .brand:
                    let queries = vm.brands.map { $0.name }
                    FilteringResultView(field: "brandName", queries: queries)
                case .color:
                    let queries = vm.colors.map { $0.name }
                    FilteringResultView(field: "scentType", queries: queries)
                }
            } label: {
                Text("Apply")
                    .frame(height: 40.0)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 20.0, style: .circular)
                    }
            }
            .tint(.primary)
            .disabled(!vm.canApplying)
        }
        .padding(.horizontal, 16.0)
        .padding(.bottom, 20.0)
        .opacity(vm.canApplying ? 1.0 : 0.0)
        .offset(y: vm.canApplying ? 0.0 : 100.0)
        .animation(.spring(), value: vm.canApplying)
    }
}
