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
            PerfumeDescriptionDetailView(flags: Array(repeating: false, count: perfumeColors.count), selectedColours: $selectedColors, isEditMode: $isEditMode, perfumeColour: perfumeColors)
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
        List {
            ForEach(Array(perfumeColour.enumerated()), id: \.1.id) { idx, value in
                DisclosureGroup(isExpanded: $flags[idx]) {
                    ForEach(value.description ?? [], id: \.self) { desc in
                        Text(desc)
                    }
                } label: {
                    HStack {
                        if selectedColours.contains(value.name) {
                            Circle()
                                .fill(value.color)
                                .frame(width: 30, height: 30)
                                .overlay(
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                )
                        } else {
                            Circle()
                                .fill(value.color)
                                .frame(width: 30, height: 30)
                        }
                        
                        Text(value.name)
                    }
                }
                .tint(.black)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
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
                            self.flags[idx].toggle()
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}
