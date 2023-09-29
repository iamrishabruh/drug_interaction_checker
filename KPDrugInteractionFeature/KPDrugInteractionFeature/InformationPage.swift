//
//  InformationPage.swift
//  KPDrugInteractionFeature
//
//  Created by Rishabh Chouhan in 8/23
//

import Foundation
import SwiftUI

struct informationPage: View {
    var body: some View {
        ZStack (alignment: .center) {
            VStack (alignment: .center) {
                
                //Heading
                Text("What are Multidrug Interactions?")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                    .multilineTextAlignment(.center)
                
                //Description
                Text("Multidrug interactions refer to the complex interplay between multiple medications taken simultaneously by an individual, which can lead to altered effects, reduced efficacy, or even adverse reactions. **Understanding multidrug interactions is crucial as it helps healthcare professionals and patients avoid potential risks and optimize treatment outcomes**.")
                    .foregroundColor(Color(hex: "013B71" ))
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .fontWeight(.regular)
                
               Spacer()
                
                //Info bubble
                ZStack {
                    Text("\n\n\n\n Multidrug interactions contribute to up to 3.8% of hospital admissions, with a prevalence of 50% in patients taking 2-4 medications and 100% in those on 10 medications\n\n\n\n")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(Color(hex:"0078B3")) //text color
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color(hex:"0078B3")) //border
                        )
                        .background(Color(hex:"F4FAFF")) //background
                        .cornerRadius(50)
                }
                Spacer()
                
            //Source Disclosure
            Text("**Source:** https://journals.lww.com/picp/fulltext/2019/10020/are_drug_drug_interactions_a_real_clinical.4.aspx")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hex:"013B71"))
                    .fontWeight(.light)
                    
            }
            .fontWeight(.thin)
            .font(.caption2)
            .padding()
        }
    }
} //Information Page

struct InfoPageView_Previews: PreviewProvider {
    static var previews: some View {
        informationPage()
    }
}
