//
//  APIReportLogic.swift
//  KPDrugInteractionFeature
//
//  Created by Rishabh Chouhan in 8/23
//

import Foundation
import SwiftUI

class APIReportLogic: ObservableObject {
    
    //User Input for Medication List
    @Published var userInputs : [String] = []
    
    //global arrays containing api call contents
    @Published var drug1Result = [String]()
    @Published var drug2Result = [String]()
    @Published var descriptionResult = [String]()
    @Published var severityResult = [String]()
    @Published var resultNumber = 0
    
    //functionality to add a card containing userInput to ContentView
    func addCard(with data: String) {
        userInputs.append(data)
    }
    
    func findRxcuiByString(searchStrings: [String], completion: @escaping ([String?]) -> Void) {
        let baseURLString = "https://rxnav.nlm.nih.gov/REST/rxcui.json?"
        var results: [String?] = []
        
        let group = DispatchGroup()
        
        for searchString in searchStrings {
            group.enter()
            
            var components = URLComponents(string: baseURLString)!
            components.queryItems = [
                URLQueryItem(name: "name", value: searchString),
            ]
            
            guard let url = components.url else {
                results.append(nil)
                group.leave()
                continue
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                defer {
                    group.leave()
                }
                
                guard let data = data, error == nil else {
                    results.append(nil)
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let idGroup = json["idGroup"] as? [String: Any],
                       let rxnormId = idGroup["rxnormId"] as? [String],
                       let rxcui = rxnormId.first {
                        results.append(rxcui)
                    } else {
                        results.append(nil)
                    }
                } catch {
                    results.append(nil)
                }
            }
            
            task.resume()
        }
        
        group.notify(queue: .main) {
            completion(results)
        }
    }
    
    func findInteractions(for rxcuiList: [String], completion: @escaping ([(drug1: String, drug2: String, description: String, severity: String)]) -> Void) {
        let baseURLString = "https://rxnav.nlm.nih.gov/REST/interaction/list.json"
        var components = URLComponents(string: baseURLString)!
        
        let rxcuis = rxcuiList.joined(separator: "+")
        components.queryItems = [
            URLQueryItem(name: "rxcuis", value: rxcuis)
        ]
        
        guard let url = components.url else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let interactionGroups = json["fullInteractionTypeGroup"] as? [[String: Any]] {
                    
                    var interactions: [(drug1: String, drug2: String, description: String, severity: String)] = []
                    
                    for interactionGroup in interactionGroups {
                        if let interactionType = interactionGroup["fullInteractionType"] as? [[String: Any]] {
                            for interaction in interactionType {
                                if let minConcept = interaction["minConcept"] as? [[String: Any]],
                                   let interactionPairs = interaction["interactionPair"] as? [[String: Any]],
                                   let severity = interactionPairs.first?["severity"] as? String,
                                   let description = interactionPairs.first?["description"] as? String {
                                    
                                    if minConcept.count >= 2,
                                       let drug1 = minConcept[0]["name"] as? String,
                                       let drug2 = minConcept[1]["name"] as? String {
                                        interactions.append((drug1: drug1, drug2: drug2, description: description, severity: severity))
                                    }
                                }
                            }
                        }
                    }
                    
                    completion(interactions)
                } else {
                    completion([])
                }
            } catch {
                completion([])
            }
        }
        
        task.resume()
    }
    
    //This function populates global arrays using the API calls detailed above
    func getReportDatafromAPI() {
        findRxcuiByString(searchStrings: userInputs) { rxcuiList in
            self.findInteractions(for: rxcuiList.compactMap { $0 }) { interactions in
                DispatchQueue.main.async { // Update the UI-related properties on the main thread
                    
                    // Clear the arrays before populating
                    self.drug1Result.removeAll()
                    self.drug2Result.removeAll()
                    self.descriptionResult.removeAll()
                    self.severityResult.removeAll()
                    self.resultNumber = 0
                    
                    // Loop through each interaction tuple in the array
                    for interaction in interactions {
                        self.drug1Result.append(interaction.drug1)
                        self.drug2Result.append(interaction.drug2)
                        self.descriptionResult.append(interaction.description)
                        self.severityResult.append(interaction.severity)
                        self.resultNumber += 1
                    }
                }
            }
        }
    }    
} //APIReportLogic
