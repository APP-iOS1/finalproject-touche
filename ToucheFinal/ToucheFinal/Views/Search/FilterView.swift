//
//  FilterView.swift
//  ToucheFinal
//
//  Created by james seo on 2023/01/30.
//

import SwiftUI
import Combine

final class FilterViewModel: ObservableObject {
    @Published var brands: [Perfume] = []
    @Published var colors: [PerfumeColor] = []
    @Published var canApplying: Bool = false
    @Published var tab: Tab = .brand
    
    enum Tab {
        case brand
        case color
    }
    
    init() {
        $brands
            .combineLatest($colors)
            .map { brands, colors -> Bool in
                return !brands.isEmpty || !colors.isEmpty
            }
            .assign(to: &$canApplying)
    }
    
    let perfumes = dummy
    let perfumeColors = PerfumeColor.types
    
    func appendBrand(_ perfume: Perfume) {
        if !brands.contains(perfume) {
            brands.append(perfume)
        }
    }
    
    func removeBrand(_ perfume: Perfume) {
        brands = brands.filter { $0.perfumeId != perfume.perfumeId }
    }
    
    func apppendColor(_ color: PerfumeColor) {
        if !colors.contains(color) {
            colors.append(color)
        }
    }
    
    func removeColor(_ color: PerfumeColor) {
        colors = colors.filter { $0.id != color.id }
    }
    
    func toggleTab(_ tab: FilterViewModel.Tab) {
        self.tab = tab
        switch self.tab {
        case .brand: colors.removeAll()
        case .color: brands.removeAll()
        }
    }
    
    func clear() {
        brands.removeAll()
        colors.removeAll()
    }
}

struct FilterView: View {
    @StateObject var vm = FilterViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            // - HEADER
            filterHeaderView()
            // - BODY
            filterBodyView()
        }
        .padding(.bottom, 40.0 + 10.0)
        .overlay(alignment: .bottom) {
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
                
                Button {
                    // TODO: - 적용 결과를 결과 뷰에 제출해야함.
                    
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
        }
        .navigationBarTitle("Filter")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FilterView()
        }
    }
}

private extension FilterView {
    func filterHeaderView() -> some View {
        Group {
            switch vm.tab {
            case .brand:
                // Brand
                HStack {
                    Text("Brand ")
                        .font(.body)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(vm.brands, id: \.self) { brand in
                                
                                HStack {
                                    Text(brand.brandName)
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
                HStack {
                    Text("Type ")
                        .font(.body)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(vm.colors, id: \.id) { perfumeColor in
                                HStack(spacing: 4.0) {
                                    Circle()
                                        .frame(width: 20)
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
    
    func filterBodyView() -> some View {
        HStack(alignment: .top, spacing: 16.0) {
            filterSelectionView()
            
            filterContentView()
        }
    }
    
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
        .frame(width: 80)
        .padding(.leading, 16.0)
    }
    
    
    
    func filterContentView() -> some View {
        Group {
            switch vm.tab {
            case .brand:
                List {
                    ForEach(vm.perfumes, id: \.perfumeId) { perfume in
                        HStack {
                            Image(systemName: "checkmark")
                                .opacity(0.0)
                            Text(perfume.brandName)
                        }
                        .onTapGesture{ vm.appendBrand(perfume) }
                    }
                }
                .listStyle(.plain)
            case .color:
                List {
                    ForEach(vm.perfumeColors) { color in
                        HStack {
                            Circle()
                                .frame(width: 20)
                                .foregroundColor(color.color)
                            Text(color.name)
                        }
                        .onTapGesture{ vm.apppendColor(color) }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

