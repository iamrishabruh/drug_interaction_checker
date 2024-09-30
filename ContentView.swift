//
//  ContentView.swift
//  KPDrugInteractionFeature
//
//  Created by Rishabh Chouhan in 8/2023
//

import SwiftUI

struct ContentView: View {
    
    //APIReportLogic contains the string array that will be queried.
    @ObservedObject var logic: APIReportLogic
    //Interaction Report page
    @State private var showInteractionReports = false
    //Initialize search bar globally so it can communicate with APIReportLogic
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .topLeading) {
                
                //Background color (for entire view)
                Color(hex: "E9EBEE")
                
                //Formatting: leading alignment
                VStack (alignment: .leading){
                    
                    //Button: back arrow
                    Button( action: {
                        print("Clicked back")
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                    }
                    .padding(.top, 50)
                    .padding(.leading, 15)
                    .foregroundColor(Color(hex: "0078B3"))
                    
                    //Title Bar (Drug interactions
                    HStack {
                        
                        //Header: "Drug Interactions ⓘ"
                        Text("Drug Interactions")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hex: "0C1C3C"))
                        
                        //Info Button
                        NavigationLink(destination:informationPage()){Text("ⓘ").fontWeight(.bold)}
                    }
                    .frame(alignment: .leading)
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 0))
                    
                    //Caption: Instructions
                    Text("Input your prescribed and over the counter medications to find more information about multi-drug interactions you may need to be aware of.")
                        .font(.footnote)
                        .fontWeight(/*@START_MENU_TOKEN@*/.light/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(red: 0.442, green: 0.467, blue: 0.535))
                        .multilineTextAlignment(.leading)
                        .lineLimit(10)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
                    
                    //ScrollView: (ZStack sets background color as white)
                    ZStack (alignment: .center) {
                        
                        //Background
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 350, height: 500)
                            .padding(15)
                        
                        VStack {
                            //Title: Medication Section
                            Text("Medications")
                                .font(.title3)
                                .fontWeight(.medium)
                                .padding(EdgeInsets(top: 25, leading: 10, bottom: -5, trailing: 200))
                                .bold()
                                .foregroundColor(Color(hex: "013B71"))
                            
                            //ScrollView: Medication Cards
                            ScrollView() {
                                VStack(alignment: .center, spacing: -25) {
                                    ForEach(logic.userInputs, id: \.self) { inputData in
                                        CardView(cardData: inputData, logic: logic)
                                            .padding()
                                    }
                                }
                            } //ScrollView
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 15))
                            
                            SearchBar(text: $searchText, onSearch: addCard)
                            
                        }
                        .frame(width: 350, height: 500)
                        .padding(15)
                        
                    } //ZStack: background color
                    .frame(width: 350, height: 500)
                    //messy fix: just alignig
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                    
                    //Button: "Check for interactions"
                    NavigationLink(destination: InteractionReports(logic: logic)) {
                        Text("Check for Interactions")
                            .font(.headline)
                            .foregroundColor(Color(hex:"0078B3")) //text color
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color(hex:"0078B3")) //button border
                            )
                            .background(Color(hex:"F4FAFF")) //button background
                            .cornerRadius(50)
                    }
                    //Button (calibrate padding here)
                    .padding(EdgeInsets(top: 35, leading: 75, bottom: 0, trailing: 75))
                }
                //Main View (calibrate padding here)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                
            }
            
            //Background color covers entire page
            .edgesIgnoringSafeArea(.all)
            
        } //Navigation View
        .accentColor(Color(hex:"0078B3"))
    }
    
    func addCard() {
        logic.addCard(with: searchText)
        searchText = "" // Clear the search text after adding the card
    }
}//MainView

struct CardView: View {
    
    let cardData: String
    let logic: APIReportLogic
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color(hex:"F7F7F7"))
            .frame(width: 300, height: 50)
            .overlay(
                HStack {
                    Image(systemName: "pill")
                        .dynamicTypeSize(.xxxLarge)
                        .foregroundColor(Color(hex: "013B71"))
                    
                    Text(cardData)
                        .font(.callout)
                        .fontWeight(.regular)
                        .foregroundColor(Color(hex: "013B71"))
                        .multilineTextAlignment(.leading)
                        .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 15))
                    
                    Spacer()
                    
                    Button(action: {
                        logic.userInputs = logic.userInputs.filter {$0 != cardData }
                    }) {
                        Image(systemName: "x.circle")
                            .dynamicTypeSize(.xLarge)
                            .foregroundColor(Color(hex: "0078B3"))
                            .padding()
                    }
                }
            )
    }
}

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            TextField("Search", text: $text, onCommit: onSearch)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(hex:"0078B3"))
            }
        }
        .padding()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(logic: APIReportLogic())
    }
}

