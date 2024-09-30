//
//  KPDrugInteractionFeatureApp.swift
//  KPDrugInteractionFeature
//
//  Created by Rishabh Chouhan on 8/17/23
//

import SwiftUI

@main
struct KPDrugInteractionFeature_UIApp: App {
    let report = APIReportLogic()
    var body: some Scene {
        WindowGroup {
            ContentView(logic: APIReportLogic())
        }
    }
}
