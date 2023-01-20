//
//  WriteCommentView.swift
//  ToucheFinal
//
//  Created by MIJU on 2023/01/18.
//

import SwiftUI

struct WriteCommentView: View {
//    @State private var reviewText: String = ""
    @State private var score: Int = 0
    @StateObject var manager = TFManager()
    @Environment(\.dismiss) var dismiss
    var perfume: Perfume
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack {
                    AsyncImage(url: URL(string: perfume.heroImage)) { image in
                        image
                            .resizable()
                            .frame(width:90, height: 90)
                    } placeholder: {
                        ProgressView()
                    }
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(perfume.displayName)
                        Spacer()
                        Text(perfume.brandName)
                            .foregroundColor(.gray)
                        Spacer()
                        
                        HStack {
                            Image(systemName: "person")
                            Text("(\(perfume.commentCount))")
                            RatingView(score: .constant(perfume.totalPerfumeScore/perfume.commentCount), frame: 15, canClick: false)
                        }
                        Spacer()
                    }
                    .frame(height: 90)
                    Spacer()
                }
                
                VStack {
                    TextField("Review", text: $manager.reviewText, axis: .vertical)
                        .padding(5)
                    Spacer()
                }
                .frame(width: 330, height: 130)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray, lineWidth: 0.5)
                )
                HStack {
                    Spacer()
                    Text("\(manager.reviewText.count)/200")
                        .foregroundColor(.gray)
                        .padding(.trailing, 13)
                }
                
                RatingView(score: $score, frame: 30, canClick: true)
                    .padding([.horizontal, .bottom])
                
                Button(action: {
                    
                }) {
                    Text("Post Review")
                        .frame(width: 330, height: 46)
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(7)
                }
                .disabled(manager.reviewText.count < 1 || score < 1)
                Spacer()
            }
            .padding()
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            })
        }
    }
}

// 150자 글자 수 제한
class TFManager: ObservableObject {
    @Published var reviewText = ""{
        didSet {
            if reviewText.count > 200 && oldValue.count <= 200 {
                reviewText = oldValue
            }
        }
    }
}

struct WriteCommentView_Previews: PreviewProvider {
    static var previews: some View {
        WriteCommentView(perfume: Perfume(perfumeId: "P258612",
                                          brandName: "CHANEL",
                                          displayName: "CHANCE EAU TENDRE Eau de Toilette",
                                          heroImage: "https://www.sephora.com/productimages/sku/s2238145-main-grid.jpg",
                                          image450: "https://www.sephora.com/productimages/sku/s2238145-main-grid.jpg",
                                          fragranceFamily: "Fresh",
                                          scentType: "Fresh Fruity Florals",
                                          keyNotes: ["Citron", "Jasmine", "Teakwood"],
                                          fragranceDescription: "The delicate and unexpected fruity-floral fragrance for women creates a soft whirlwind of happiness, fantasy, and radiance.",
                                          likedPeople: ["1", "2"],
                                          commentCount: 154,
                                          totalPerfumeScore: 616
                                         ))
    }
}
