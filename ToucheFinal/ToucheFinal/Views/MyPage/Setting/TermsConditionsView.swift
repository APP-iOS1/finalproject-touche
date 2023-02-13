//
//  TermsConditionsView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/13.
//

import SwiftUI

struct TermsConditionsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
            NavigationView{
                VStack{
                    Image("touche2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 50)
                    VStack(alignment: .leading){
                        Group{
                            Text("Touche Terms & Conditions")
                                .fontWeight(.bold)
                                .padding(.bottom, 7)
                            Text("(1) Privacy Processing")
                                .fontWeight(.semibold)
                                .padding(.bottom, 4)
                            Text("The protection of natural persons in relation to the processing of personal data is a fundamental right. Article 8(1) of the Charter of Fundamental Rights of the European Union (the 'Charter') and Article 16(1) of the Treaty on the Functioning of the European Union (TFEU) provide that everyone has the right to the protection of personal data concerning him or her.")
                                .padding(.bottom, 4)
                            
                            Text("(2) Personal Information Processing Protection")
                                .fontWeight(.semibold)
                                .padding(.bottom, 4)
                            Text ("The principles of, and rules on the protection of natural persons with regard to the processing of their personal data should, whatever their nationality or residence, respect their fundamental rights and freedoms, in particular their right to the protection of personal data. This Regulation is intended to contribute to the accomplishment of an area of freedom, security and justice and of an economic union, to economic and social progress, to the strengthening and the convergence of the economies within the internal market, and to the well-being of natural persons.")
                                .padding(.bottom, 4)
                            
                            Text("(3) Personal information processing activities")
                                .fontWeight(.semibold)
                                .padding(.bottom, 4)
                            Text("Directive 95/46/EC of the European Parliament and of the Council¹seeks to harmonise the protection of fundamental rights and freedoms of natural persons in respect of processing activities and to ensure the free flow of personal data between Member States")
                                .padding(.bottom, 4)
                        }
                    }
                    .padding()
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
        }
    }


struct TermsConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsConditionsView()
    }
}
