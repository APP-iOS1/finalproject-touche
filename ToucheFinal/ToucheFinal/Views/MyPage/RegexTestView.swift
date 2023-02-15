//
//  RegexTestView.swift
//  ToucheFinal
//
//  Created by 홍진표 on 2023/02/15.
//

import SwiftUI

struct RegexTestView: View {
    
    @State private var text: String = ""
    
    var body: some View {
        TextField("Enter text", text: $text)
                    .onChange(of: text) { newValue in
                        let regex = try! NSRegularExpression(pattern: "[0-9]+")
                        let range = NSRange(location: 0, length: newValue.utf16.count)
                        let matches = regex.matches(in: newValue, range: range)
                        if matches.count == 0 {
                            self.text = String(newValue.dropLast())
                        }
                    }
    }
}

struct RegexTestView_Previews: PreviewProvider {
    static var previews: some View {
        RegexTestView()
    }
}
