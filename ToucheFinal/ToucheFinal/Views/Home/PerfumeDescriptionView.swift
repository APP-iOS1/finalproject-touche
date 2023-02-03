//
//  PerfumeDescriptionView.swift
//  ToucheFinal
//
//  Created by 홍진표 on 2023/01/30.
//

import SwiftUI

struct PerfumeDescriptionView: View {
    @State var seletedColors = (UserDefaults.standard.array(forKey: "selectedScentTypes") as? [String] ?? [])
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var perfumeColors: [PerfumeColor] = PerfumeColor.types
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Select: ")
                    .font(.title)
                    .fontWeight(.bold)
                //.padding(.leading, 20)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(seletedColors, id: \.self) { color in
                            Circle()
                                .fill(Color(scentType: color))
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                .padding(.leading, -5)
                
                Divider()
            }
            .padding(.leading, 20)
            
            PerfumeDescriptionDetailView(flags: Array(repeating: false, count: perfumeColors.count), selectedColours: $seletedColors, perfumeColour: perfumeColors)
                .padding(.top, -8)
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
    @Binding var selectedColours: [String]
    
    var perfumeColour: [PerfumeColor]
    
    var body: some View {
        ScrollView {
            ForEach(Array(perfumeColour.enumerated()), id: \.1.id) { idx, value in
                /*
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
                 */
                
                HStack {
                    HStack {
                        Circle()
                            .fill(value.color)
                            .frame(width: 30, height: 30)
                        
                        Text(value.name)
                            .fontWeight(.bold)
                    }
                    //  .border(.black)
                    .onTapGesture {
                        if let index = selectedColours.firstIndex(of: value.name) {
                            
                            if (selectedColours.count > 1) {
                                
                                selectedColours.remove(at: index)
                            }
                        } else {
                            
                            selectedColours.append(value.name)
                        }
                        
                        UserDefaults.standard.set(selectedColours, forKey: "selectedScentTypes")
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .rotationEffect(Angle(degrees: flags[idx] ? 90 : 0))
                        .onTapGesture {
                            withAnimation {
                                self.flags[idx].toggle()
                            }
                        }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                if (flags[idx]) {
                    Text(value.description?[0] ?? "")
                        .padding([.horizontal, .bottom])
                }
                
                Divider()
            }
        }
        .listStyle(.plain)
    }
}
