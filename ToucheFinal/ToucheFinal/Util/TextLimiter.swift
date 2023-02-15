//
//  TextLimiter.swift
//  ToucheFinal
//
//  Created by 홍진표 on 2023/02/14.
//

import Foundation
import Combine

//  ref: https://mac-user-guide.tistory.com/92
class TextLimiter: ObservableObject {
    
    @Published var value: String = "" {
        
        didSet(oldVal) {    //  value의 값이 변경된 직후에 호출, oldVal은 변경 전 value의 값
            
            print("oldVal: \(oldVal)")
            
            if (value.count > self.limit) {
                
                value = String(value.prefix(self.limit))
                
                self.hasReachedLimit = true
            } else {
                
                self.hasReachedLimit = false
            }
        }
        
        /*
        willSet(newVal) {   //  value의 값이 변경되기 직전에 호출, newVal은 변경 될 새로운 값
            
            print("NEW_VAL: \(newVal)")
        }
         */
    }
    @Published var hasReachedLimit: Bool = false
    
    private let limit: Int
    
    init(limit: Int) {
        self.limit = limit
    }
}
