//
//  LongDescriptionParsing.swift
//  ToucheFinal
//
//  Created by 홍진표 on 2023/01/18.
//

import Foundation
import SwiftSoup

/// HTML코드가 제거된 LongDescription을 받아서 Fragrance Family, Scent Type, Key Notes로 가공해줌.
func makeDescription(longDesc: String) -> (String, String, [String]) {
    
    var string: String = ""
    
    //  html태그가 들어 있는 String타입 값에서 태그를 제거하는 부분(Line 43 ~ 55)
    do {
        
        let doc: Document = try SwiftSoup.parse(longDesc)
        
        //print(try doc.text())
        
        string = try doc.text()
        
    } catch Exception.Error(_, _) {
        print("")
    } catch {
        print("")
    }
    
    
    //MARK: - Step1. 띄어쓰기 제거
    /// string을 좀 더 편하게 가공하기 위해 띄어쓰기를 제거함
    var step1 = ""
    for i in string {
        if i != " " {
            step1.append(i)
        }
    }
    //MARK: - Step2. 문자열을 Fragrance Family, Scent Type, Key Notes로 나누기
    var step2 = ""
    
    var family = ""
    var type = ""
    var keyNotes = ""
    
    /// HTML코드와 띄어쓰기가 제거된 step2: String을 갖고
    /// Fragrance Family, Scent Type, Key Notes로 가공함
    /// 조건문을 통해 아래의 형태로 만들어준다
    
    ///[family]: FreshScentT
    ///[type]: FreshCitrus&FruitsKeyNot
    ///[keyNotes]: Citron,Jasmine,TeakwoodFragra
    for (idx, char) in step1.enumerated() {
        
        if step2.contains("ScentType:") {
            if !step2.contains("KeyNot") {
                type.append(char)
            }
        }
        
        if step2.contains("KeyNotes:") {
            
            if !step2.contains("Fragra") && !step2.contains("About:") {
                keyNotes.append(char)
            }
        }
        
        if idx > 15 {
            step2.append(char)
            if !step2.contains("ScentTy") {
                family.append(char)
            }
        }
    }
    
    ///[family]: FreshScentT
    ///[type]: FreshCitrus&FruitsKeyNot
    ///[keyNotes]: Citron,Jasmine,TeakwoodFragra
    /// 각 문자열의 뒤의 글자들을 지워준다. (뒤의 남는 글자를 6개로 맞춤)
    for _ in 0...5 {
        family.removeLast()
        keyNotes.removeLast()
        type.removeLast()
    }
    
    
    //MARK: - Step3. "ScentType" 띄어쓰기 및 "KeyNotes" 배열로 변환
    /// [type]: FreshCitrus&Fruits -> Fresh Citrus & Fruits
    /// [keyNotes]: Citron,Jasmine,Teakwood -> [Citron,Jasmine,Teakwood]
    var finalType = ""
    var finalKeyNotes = [String]()
    
    for (idx, char) in type.enumerated() {
        
        if char == "&" {
            finalType.append(" ")
        } else if idx > 0 && char.isUppercase {
            finalType.append(" ")
        }
        
        finalType.append(char)
    }
    
    var note = ""
    for (idx, char) in keyNotes.enumerated() {
        if char != "," {
            note.append(char)
        } else {
            finalKeyNotes.append(note)
            note = ""
        }
        if idx == (keyNotes.count - 1) {
            finalKeyNotes.append(note)
        }
    }
    
    //      fraganceFamily, scentType, keyNotes
    return (family, finalType, finalKeyNotes)
}

/*
 func removeHTMLTag(longDesc: String) -> String {
 
 do {
 
 let doc: Document = try SwiftSoup.parse(longDesc)
 
 print(try doc.text())
 
 return try doc.text()
 
 } catch Exception.Error(let type, _) {
 print("")
 } catch {
 print("")
 }
 
 return ""
 }
 */
