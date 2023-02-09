//
//  PerfumeDescriptionView.swift
//  ToucheFinal
//
//  Created by 홍진표 on 2023/01/30.
//

import SwiftUI

struct PerfumeDescriptionView: View {
    @State var selectedColors = (UserDefaults.standard.array(forKey: "selectedScentTypes") as? [String] ?? [])
    @State var isEditMode = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var perfumeColors: [PerfumeColor] = PerfumeColor.types
    
    var body: some View {
        VStack(alignment: .leading) {
//            HStack {
//                Text("Select: ")
//                    .font(.title)
//                    .fontWeight(.bold)
//                //.padding(.leading, 20)
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(selectedColors, id: \.self) { color in
//                            Circle()
//                                .fill(Color(scentType: color))
//                                .frame(width: 30, height: 30)
//                                .onTapGesture {
//                                    if selectedColors.count > 1 {
//                                        selectedColors.remove(at: selectedColors.firstIndex(of: color) ?? 0)
//                                        UserDefaults.standard.set(selectedColors, forKey: "selectedScentTypes")
//                                    }
//                                }
//                        }
//                    }
//                }
//                .padding(.leading, -5)
//
//            }
//            .frame(height: 30)
//            .padding(.leading, 20)
//            Divider()
            PerfumeDescriptionDetailView(flags: Array(repeating: false, count: perfumeColors.count), selectedColours: $selectedColors, isEditMode: $isEditMode, perfumeColour: perfumeColors)
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isEditMode.toggle()
                } label: {
                    if isEditMode {
                        Text("Save")
                    } else {
                        Text("Edit")
                    }
                }
                .foregroundColor(.black)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("ScentType Description")
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
    @Binding var isEditMode: Bool
    var perfumeColour: [PerfumeColor]
    
    var body: some View {
        ScrollView {
            ForEach(Array(perfumeColour.enumerated()), id: \.1.id) { idx, value in
                Button {
                    if isEditMode {
                        if let index = selectedColours.firstIndex(of: value.name) {
                            if (selectedColours.count > 1) {
                                selectedColours.remove(at: index)
                            }
                        } else {
                            selectedColours.append(value.name)
                        }
                        UserDefaults.standard.set(selectedColours, forKey: "selectedScentTypes")
                    } else {
                        withAnimation {
                            self.flags[idx].toggle()
                        }
                    }
                } label: {
                    HStack {
                        Circle()
                            .fill(value.color)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Image(systemName: selectedColours.contains(value.name) ? "checkmark" : "")
                                    .foregroundColor(.white))
                        Text(value.name)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .rotationEffect(Angle(degrees: flags[idx] ? 90 : 0))
                    }
                }
                .foregroundColor(.black)
                .padding(.horizontal)
                .padding(.top, 10)
                
                if (flags[idx]) {
                    Text(value.description?[0] ?? "")
                        .padding([.horizontal, .bottom])
                }
                
                Divider()
            }
        }
    }
}
