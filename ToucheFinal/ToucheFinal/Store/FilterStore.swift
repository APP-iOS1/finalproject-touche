//
//  FilterStore.swift
//  ToucheFinal
//
//  Created by 김태성 on 2023/02/13.
//

import Foundation

class FilterStore: ObservableObject {
    @Published var isShowingOverCheckedBrandAlert = false
    @Published var isShowingOverCheckedColorAlert = false
}
