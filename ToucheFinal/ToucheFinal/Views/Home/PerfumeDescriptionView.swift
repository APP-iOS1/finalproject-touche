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
    @State var flags = Array(repeating: false, count: 16)
    @State private var selectedIndex: Int = 16

    @EnvironmentObject var userInfoStore: UserInfoStore
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var perfumeColors: [PerfumeColor] = PerfumeColor.types
    
    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(Array(perfumeColors.enumerated()), id: \.1.id) { idx, value in
                    VStack {
                        ForEach(value.description ?? [], id: \.self) { desc in
                            HStack {
                                if isEditMode {
                                    Image(systemName: selectedColors.contains(value.name) ? "checkmark.circle" : "circle")
                                        .foregroundColor(selectedColors.contains(value.name) ? .green : .gray)
                                }
                                HStack {
                                    Circle()
                                        .fill(value.color)
                                        .frame(width: 30, height: 30)
                                    Text(value.name)
                                    if selectedColors.contains(value.name) && !isEditMode{
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.green)
                                    }
                                    Spacer()
                                    Image(systemName: selectedIndex == idx ? "chevron.up" : "chevron.down")
                                }
                                .padding(.vertical, 5)
                            }
                            if selectedIndex == idx {
                                Divider()
                                Text(desc)
                            }
                        }
                    }
                    .tint(.black)
                    .contentShape(Rectangle())
                    .id(value.id)
                    .onTapGesture {
                        if isEditMode {
                            if let index = selectedColors.firstIndex(of: value.name) {
                                if (selectedColors.count > 1) {
                                    selectedColors.remove(at: index)
                                } else {
                                    // 한개 남았을때 알럿 보여주기 위한 토글
                                    userInfoStore.isShowingScentTypeDesciptionAlert.toggle()
                                }
                            } else {
                                selectedColors.append(value.name)
                            }
                            UserDefaults.standard.set(selectedColors, forKey: "selectedScentTypes")
                        } else {
                            if selectedIndex != 16 {
                                flags[selectedIndex] = false
                            }
                            if selectedIndex == idx {
                                selectedIndex = 16
                            } else {
                                withAnimation {
                                    selectedIndex = idx
                                    flags[selectedIndex] = true
                                }
                            }
                        }
                    }
                    .onChange(of: flags[idx]) { newValue in
                        if newValue {
                            if idx != 15 {
                                proxy.scrollTo(value.id, anchor: .top)
                            } else {
                                proxy.scrollTo(value.id, anchor: .center)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            Spacer()
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
                    withAnimation {
                        isEditMode.toggle()
                    }
                    if isEditMode && selectedIndex != 16 {
                        flags[selectedIndex] = false
                        selectedIndex = 16
                    }
                } label: {
                    if isEditMode {
                        Text("Done")
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
