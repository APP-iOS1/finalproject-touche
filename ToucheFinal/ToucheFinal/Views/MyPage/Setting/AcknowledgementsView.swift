//
//  LicencesView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/16.
//

import SwiftUI

struct AcknowledgementsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            HStack{
                VStack(alignment: .leading){
                    Text("We use\nthese open source libraries\nto make Touché")
                        .font(.system(size: 35))
                        .fontWeight(.semibold)
                        .padding(.bottom, 15)
                        .padding(.top, 10)
                    Group{
                        Text("Source Libraries:")
                            .fontWeight(.semibold)
                        Text("AlertToast")
                        Text("Magnetic")
                        Text("SDWebImageSwiftUI")
                        Text("Segemented Picker")
                        Text("SwiftSoup")
                    }
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)
                    //Spacer()
                    Group{
                        Text("API:")
                            .fontWeight(.semibold)
                        
                            Text("The data used by Touché")
                        HStack{
                            Text("is from")
                            Text("Sephora API")
                                .underline(true, color: .gray)
                        }
                    }
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)
                    Spacer()
                }
                .padding()
                Spacer()
            }
               
                
                .navigationBarTitle("Acknowledgements", displayMode: .inline)
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
        } // NAVIGATIONVIEW
    }
}

struct LicencesView_Previews: PreviewProvider {
    static var previews: some View {
        AcknowledgementsView()
    }
}
