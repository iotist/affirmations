//
//  MainViewModel.swift
//  Affirmations
//
//  Created by sherzodbek on 8/1/24.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var affirmations: [Affirmation] = []
    @Published var userSettings: UserSetting
    
    init() {
        userSettings = UserSetting()
        fetchUserSettings()
        fetchAffirmations()
    }
    
    func fetchUserSettings() {
        if let settings = DataManager.shared.fetchUserSettings() {
            userSettings.selectedCategory = settings.category
            userSettings.selectedBackgroundColor = settings.backgroundColor
            userSettings.selectedGender = settings.gender
            userSettings.selectedLanguage = settings.language
        }
    }
    
    func fetchAffirmations() {
        affirmations = DataManager.shared.fetchAffirmations(by: userSettings.selectedCategory ?? "Love")
    }
}
