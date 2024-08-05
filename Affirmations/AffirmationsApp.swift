//
//  AffirmationsApp.swift
//  Affirmations
//
//  Created by sherzodbek on 8/1/24.
//

import SwiftUI

@main
struct AffirmationsApp: App {
    let persistenceController = DataManager.shared

    @StateObject private var userSettings = UserSetting()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(userSettings)
        }
    }
}
