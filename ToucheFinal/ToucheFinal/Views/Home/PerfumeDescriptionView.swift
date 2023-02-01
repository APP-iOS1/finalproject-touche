//
//  PerfumeDescriptionView.swift
//  ToucheFinal
//
//  Created by 홍진표 on 2023/01/30.
//

import SwiftUI

struct PerfumeDescriptionView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var perfumeColors: [PerfumeColor] = PerfumeColor.types
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Select: ")
                    .font(.title)
                    .fontWeight(.bold)
                    //.padding(.leading, 20)
                
                Text("(여기에 온보딩에서 선택한 값이 들어갈 예정)")
            }
            .padding(.leading, 20)
            
            PerfumeDescriptionDetailView(flags: Array(repeating: false, count: perfumeColors.count), perfumeColour: perfumeColors)
        }
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

struct PerfumeDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        PerfumeDescriptionView()
    }
}

//MARK: - Perfume Description Detail View
struct PerfumeDescriptionDetailView: View {
    
    @State var flags: [Bool]
    var perfumeColour: [PerfumeColor]
    
    var body: some View {
        List {
            ForEach(Array(perfumeColour.enumerated()), id: \.1.id) { idx, value in
                DisclosureGroup(isExpanded: $flags[idx]) {
                    ForEach(value.description ?? [], id: \.self) { desc in
                        Text(desc)
                    }
                } label: {
                    HStack {
                        Circle()
                            .fill(value.color)
                            .frame(width: 30, height: 30)
                        
                        Text(value.name)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        self.flags[idx].toggle()
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}
