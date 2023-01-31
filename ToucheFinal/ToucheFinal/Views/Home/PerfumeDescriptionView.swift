//
//  PerfumeDescriptionView.swift
//  ToucheFinal
//
//  Created by 홍진표 on 2023/01/30.
//

import SwiftUI

struct PerfumeDescriptionView: View {
    
    //var perfumeColor: [PerfumeColor] = PerfumeColor.types
    
    let items: [Bookmark] = [.example1, .example2, .example3]
    
    /*
    let arr = [PerfumeColor.elements[0],
               PerfumeColor.elements[1],
               PerfumeColor.elements[2],
               PerfumeColor.elements[3],
               PerfumeColor.elements[4],
               PerfumeColor.elements[5],
               PerfumeColor.elements[6],
               PerfumeColor.elements[7],
               PerfumeColor.elements[8],
               PerfumeColor.elements[9],
               PerfumeColor.elements[10],
               PerfumeColor.elements[11],
               PerfumeColor.elements[12],
               PerfumeColor.elements[13],
               PerfumeColor.elements[14],
               PerfumeColor.elements[15]
    ]
     */
    
    var array = PerfumeColor.types
    
    var body: some View {
        
        
         List {
         //Text("Selection: \(perfumeColor[0].name)")
         
         ForEach(PerfumeColor.types, id: \.self) { colour in
         HStack {
         Circle()
         .fill(colour.color)
         .frame(width: 30, height: 30)
         
         Text(colour.name)
         }
         }
         }
         
        
        
        
        
//        List(items, children: \.items) { row in
//            HStack {
//                Image(systemName: row.icon)
//                Text(row.name)
//            }
//        }
        
//        List(array, id: \.self, children: \.desc) { e in
//            Text(e.desc?[0] ?? "")
//        }
    }
}

struct PerfumeDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        PerfumeDescriptionView()
    }
}
