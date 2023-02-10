//
//  SelectNationView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/19.
//

import SwiftUI

enum ToucheNation {
    case RepublicOfKorea
    case France
    case UnitedStates
    case Japan
    func getLanguageCode() -> String{
        switch self {
        case .RepublicOfKorea:
            return "kr"
        case .France:
            return "fr"
        case .UnitedStates:
            return "un"
        case .Japan:
            return "jp"
        }
    }
}


struct SelectNationView: View {
    
    

    @Environment(\.dismiss) var dismiss

    @State var nations: [String] = ["Korean","English (US)"].sorted()

    @State private var selectingNation: String = ""

    @State private var selectedNations: [String] = []

    @AppStorage("selectedNation") private var selectedNation: String?
    
//    @AppStorage("language")
//    private var language = LocalizationService.shared.language

    var body: some View {

        // 수동으로 바인딩하는 방법
        let selectBinding = Binding<String> (
            get: { selectingNation },
            set: {
                selectingNation = $0
                if !selectingNation.isEmpty {
                    selectedNations = nations.filter{$0.lowercased().contains(selectingNation.lowercased())}
                } else {
                    selectedNations = nations
                }
            }

        )

        NavigationView {
            return VStack{
                TextField("Search Your Nation", text: selectBinding)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List{
                    ForEach(selectedNations, id: \.self){ nation in
                        Button{
                            self.selectedNation = nation
                            UserDefaults.standard.set([selectedNation], forKey: "ToucheNation")
                            UIApplication.shared.requestSceneSessionActivation(nil, userActivity: nil, options: nil, errorHandler: nil)
                            // MARK: -선택 시 앱 내에서 로컬라이제이션 기능이 적용
                            if selectedNation == "Korean" {
                                LocalizationService.shared.language = .korean
                            } else {
                                LocalizationService.shared.language = .english
                            }
                        } label: {
                            Text(nation)
                        }


                    }
                }.listStyle(.plain)
            }

            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
        .onAppear{
            selectedNations = nations
        }
    }

}

struct SelectNationView_Previews: PreviewProvider {

    //    static let sampleData = ["RepublicOfKorea","France","UnitedStates","Japan"].sorted()

    static var previews: some View {
        SelectNationView()
    }
}
