//
//  ContentView.swift
//  Affirmations
//
//  Created by sherzodbek on 8/1/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
//    @EnvironmentObject var userSettings: UserSetting
    
    var body: some View {
        if isOnboarding {
            OnboardingView()
        } else {
            MainView()
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
