//
//  TestMagazineUploadView.swift
//  ToucheFinal
//
//  Created by TAEHYOUNG KIM on 2023/02/09.
//

import SwiftUI
import PhotosUI

struct TestMagazineUploadView: View {
    @State private var selectedContentItem: PhotosPickerItem?
    @State private var selectedBodyItem: PhotosPickerItem?
    @State var selectedContentImage: Image?
    @State var selectedContentUImage: UIImage?
    @State var selectedBodyImage: Image?
    @State var selectedBodyUImage: UIImage?
    @State var title: String = ""
    @State var subTitle: String = ""

    @StateObject var vm = MagazineStore()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    TextField("title", text: $title)
                    TextField("subTitle", text: $subTitle)
                    
                    GeometryReader { proxy in
                        let size = proxy.size
                        if let selectedContentImage {
                            selectedContentImage
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .cornerRadius(30)
                                .shadow(radius: 10)
                            
                        } else {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .fill(.white)
                                .frame(width: size.width, height: size.height)
                                .shadow(radius: 10)
                        }
                    }
                    .padding()
                    .frame(height: 400)
                    
                    PhotosPicker("Select Content Image", selection: $selectedContentItem, matching: .images, photoLibrary: .shared())
                        .buttonStyle(.bordered)
                        .onChange(of: selectedContentItem) { _ in
                            Task {
                                if let data = try? await selectedContentItem?.loadTransferable(type: Data.self) {
                                    if let uiImage = UIImage(data: data) {
                                        selectedContentUImage = uiImage
                                        selectedContentImage = Image(uiImage: uiImage)
                                        
                                        print("사진선택됨")
                                        return
                                    }
                                }
                            }
                        }
                    
                    
                    GeometryReader { proxy in
                        let size = proxy.size
                        if let selectedBodyImage {
                            selectedBodyImage
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .cornerRadius(30)
                            
                        } else {
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .fill(.white)
                                .frame(width: size.width, height: size.height)
                                .shadow(radius: 10)
                        }
                    }
                    .padding()
                    .frame(height: 400)
                    
                    PhotosPicker("Select Body Image", selection: $selectedBodyItem, matching: .images, photoLibrary: .shared())
                        .buttonStyle(.bordered)
                        .onChange(of: selectedBodyItem) { _ in
                            Task {
                                if let data = try? await selectedBodyItem?.loadTransferable(type: Data.self) {
                                    if let uiImage = UIImage(data: data) {
                                        selectedBodyUImage = uiImage
                                        selectedBodyImage = Image(uiImage: uiImage)
                                        
                                        print("사진선택됨")
                                        return
                                    }
                                }
                            }
                        }
                    
                    
                    Spacer()
                    
                    Button("Upload") {
                        let magazine = Magazine(id: UUID().uuidString, title: title, subTitle: subTitle, contentImage: "", bodyImage: "", createdDate: 0, perfumeIds: ["P12420", "P12495"])
                        Task {
                            await vm.createMagazine(magazine: magazine, selectedContentUImage: selectedContentUImage, selectedBodyUImage: selectedBodyUImage)
                        }
                    }
                    
                    
                }
                .navigationTitle("PhotosPicker")
            }
        }
    }
}

struct TestMagazineUploadView_Previews: PreviewProvider {
    static var previews: some View {
        TestMagazineUploadView()
    }
}