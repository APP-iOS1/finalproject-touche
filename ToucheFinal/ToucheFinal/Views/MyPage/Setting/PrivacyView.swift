//
//  PrivacyView.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/02/13.
//

import SwiftUI

struct PrivacyView: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        NavigationView{
            ScrollView{
                VStack{
                    Image("touche2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 50)
                    
                    VStack(alignment: .leading){
                        Group{
                            Text("Touché Privacy Policy")
                                .fontWeight(.semibold)
                                .font(.system(size: 19))
                                .padding(.bottom, 7)
                            
                            Text("(1) Privacy Processing")
                                .modifier(Title())
                                
                            
                            Text("The protection of natural persons in relation to the processing of personal data is a fundamental right. Article 8(1) of the Charter of Fundamental Rights of the European Union (the 'Charter') and Article 16(1) of the Treaty on the Functioning of the European Union (TFEU) provide that everyone has the right to the protection of personal data concerning him or her.")
                              
                            
                            Text("(2) Personal Information Protection")
                                .modifier(Title())
                                
                            
                            Text ("The principles of, and rules on the protection of natural persons with regard to the processing of their personal data should, whatever their nationality or residence, respect their fundamental rights and freedoms, in particular their right to the protection of personal data. This Regulation is intended to contribute to the accomplishment of an area of freedom, security and justice and of an economic union, to economic and social progress, to the strengthening and the convergence of the economies within the internal market, and to the well-being of natural persons.")
                              
                            
                            Text("(3) Personal Information Activities")
                                .modifier(Title())
                                
                            
                            Text("Directive 95/46/EC of the European Parliament and of the Council¹seeks to harmonise the protection of fundamental rights and freedoms of natural persons in respect of processing activities and to ensure the free flow of personal data between Member States")
                              
                            
                            Text("(4) The Processing of Personal Data")
                                .modifier(Title())
                            
                            Text("The processing of personal data should be designed to serve mankind. The right to the protection of personal data is not an absolute right; it must be considered in relation to its function in society and be balanced against other fundamental rights, in accordance with the principle of proportionality. This Regulation respects all fundamental rights and observes the freedoms and principles recognised in the Charter as enshrined in the Treaties, in particular the respect for private and family life, home and communications,the protection of personal data, freedom of thought, conscience and religion, freedom of expression and information, freedom to conduct a business, the right to an effective remedy and to a fair trial, and cultural, religious and linguistic diversity.")
                        }
                        .padding(.bottom, 7)
                        
                        Group{
                            Text("(5) Duties of Exchange Personal Data")
                                .modifier(Title())
                            
                            Text("The economic and social integration resulting from the functioning of the internal market has led to a substantial increase in cross-border flows of personal data. The exchange of personal data between public and private actors, including natural persons, associations and undertakings across the Union has increased. National authorities in the Member States are being called upon by Union law to cooperate and exchange personal data so as to be able to perform their duties or carry out tasks on behalf of an authority in another Member State.")
                            
                            Text("(6) Privacy Policy Level")
                                .modifier(Title())
                            
                            Text("Rapid technological developments and globalisation have brought new challenges for the protection of personal data. The scale of the collection and sharing of personal data has increased significantly. Technology allows both private companies and public authorities to make use of personal data on an unprecedented scale in order to pursue their activities. Natural persons increasingly make personal information available publicly and globally. Technology has transformed both the economy and social life, and should further facilitate the free flow of personal data within the Union and the transfer to third countries and international organisations, while ensuring a high level of the protection of personal data.")
                            
                            Text("(7) Protection Framework")
                                .modifier(Title())
                            Text("Those developments require a strong and more coherent data protection framework in the Union, backed by strong enforcement, given the importance of creating the trust that will allow the digital economy to develop across the internal market. Natural persons should have control of their own personal data. Legal and practical certainty for natural persons, economic operators and public authorities should be enhanced.")
                            
                        }
                        .padding(.bottom, 7)
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
            .navigationBarTitle("Privacy policy", displayMode: .inline)
        }
    }
}


struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
