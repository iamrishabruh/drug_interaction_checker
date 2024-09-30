//
//  InteractionReports.swift
//  KPDrugInteractionFeature
//
//  Created by Rishabh Chouhan in 8/23
//

import SwiftUI

struct InteractionReports: View {
    
    var logic: APIReportLogic
    
    //Makes api call
    init(logic: APIReportLogic) {
            self.logic = logic  // Assign the parameter to the property
            logic.getReportDatafromAPI()
        }
    
    var body: some View {
        
        ZStack () {
            
            //sets background color
            Color(hex: "E9EBEE")
            
            //main content of page
            VStack (alignment: .leading) {
                
                //Heading 1
                Text("Drug Interactions Report")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hex: "0C1C3C"))
                    .padding(EdgeInsets(top: 100, leading: 15, bottom: 5, trailing: 0))
                
               //Caption 1
                Text("Detailed below are multi-drug interactions relevant to you with their associated levels of severity ")
                    .font(.footnote)
                    .fontWeight(/*@START_MENU_TOKEN@*/.light/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(red: 0.442, green: 0.467, blue: 0.535))
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .trailing])
                
               //Report cards in a scrollView
                VStack (alignment: .center) {
                    ScrollView {
                        VStack{ //}(spacing: -100) {
                            if (logic.resultNumber == 0) {
                                noReportFound()
                            } else {
                                ForEach(0..<logic.resultNumber, id: \.self) { index in
                                    reportCard(drug1: logic.drug1Result[index],
                                               drug2: logic.drug2Result[index],
                                               description: logic.descriptionResult[index],
                                               severity: logic.severityResult[index]
                                    ) .padding(EdgeInsets(top: 1, leading: 15, bottom: 1, trailing: 15))
                                } //iteration through arrays...
                            } //else
                            Text("Note: Information is sourced from the NIH. KP is not liable for the presented information. Consult your physician for accuracy.")
                                .font(.caption2)
                                .fontWeight(.thin)
                                .padding(EdgeInsets(top: 0, leading: 18, bottom: 45, trailing: 10))
                                .background(Color(hex: "E9EBEE"))
                                .foregroundColor(Color(.gray))
                        } //VStack
                    } //ScrollView
                }
            } .frame(maxWidth: .infinity, maxHeight: .infinity)
        } .edgesIgnoringSafeArea(.all)
    }
}

struct noReportFound: View {
    var body : some View {
        ZStack {
            VStack (alignment: .center) {
                Text("No Reports Found")
                    .font(.title)
                    .fontWeight(.thin)
                    .foregroundColor(Color(.gray))
                    .padding()
                
                Text("If you have greater than five medications, this may be unlikely. Make sure that medication names are typed in correctly. \n\nOtherwise, you have no drug-drug interactions to be worried about :)")
                    .font(.subheadline)
                    .fontWeight(.thin)
                    .foregroundColor(Color(.gray))
                    .multilineTextAlignment(.center)
                    .padding()
                
            } //VStack
            .cornerRadius(15)
            .padding(EdgeInsets(top: 190, leading: 15, bottom: 170 , trailing: 15))
            .overlay(
                        RoundedRectangle(cornerRadius: 20) // Adjust the corner radius value as needed
                            .stroke(Color.gray, lineWidth: 1)
                    )
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5 , trailing: 15))
            
        } //ZStack
        
    }
}

struct reportCard: View {
    
    //Four parameters needed to create a reportCard
    let drug1: String
    let drug2: String
    let description: String
    let severity: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //format parameters to appropriate forms
            let drug1Formatted = formatString(drug1)
            let drug2Formatted = formatString(drug2)
            let severityFormatted = formatSeverity(severity)
            let severityColor = severityColor(severity)
            
            HStack {
                
                //Severity Heading
                Text("\(severityFormatted) Risk")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                    .font(.title3)
                Spacer()
                
                //Severity Icon
                Circle()
                    .fill(Color(hex:severityColor))
                    .frame(width: 22, height: 22)
            }
            VStack(alignment: .leading, spacing: 2) {
                
                //Drug1 Name
                Text(drug1Formatted)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hex:"0078B3"))
                
               //Drug2 Name
                Text(drug2Formatted)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hex:"0078B3"))
                
            }
            
            //Explanation of drug interaction
            Text(description)
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(Color(hex: "7F8596"))
                .fixedSize(horizontal: false, vertical: true)
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
        }
        .padding(15)
        .background(Color.white)
        .cornerRadius(15)
    }
}
   
//This function is used to format drug names to be all lower case starting with a capital letter
func formatString(_ input: String) -> String {
    let lowercasedInput = input.lowercased()
    let firstLetter = lowercasedInput.prefix(1).capitalized
    let restOfString = lowercasedInput.dropFirst()
    
    return firstLetter + restOfString
}

//This function is used to make severity label more user friendly
func formatSeverity(_ input: String) -> String {
    var formattedInput = ""
    
    if input == "N/A" {
        formattedInput = "Some"
    } else {
        formattedInput = formatString(input)
    }
    
    return formattedInput
}

//This function determines the dot color next to the risk warning based on level of risk.
func severityColor(_ input: String) -> String {
    
    var severityColor = "9DC9DF" //baby blue
    
    if input == "high" {
        severityColor = "EF2828" //red
    } else if input == "moderate" {
        severityColor = "EFAB28" //orange
    } else if input == "low" {
        severityColor = "EED602" //yellow
    }
    
    return severityColor
}

//preview
struct InteractionReports_Previews: PreviewProvider {
    static var previews: some View {
        InteractionReports(logic: APIReportLogic())
    }
}
