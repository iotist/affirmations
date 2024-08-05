//
//  SettingsViewModel.swift
//  Affirmations
//
//  Created by sherzodbek on 8/1/24.
//

import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    @Published var selectedCategory: String
    @Published var selectedBackgroundColor: String
    @Published var selectedGender: String
    @Published var selectedLanguage: String
    
    @Published var affirmation: Affirmation?
    @Published var themes: [String] = []
    @Published var categories: [String] = []
    
    @Published var userSettings: UserSetting
    
    init(_ userSetting: UserSetting) {
        let settings = DataManager.shared.userSettings
        selectedCategory = userSetting.selectedCategory ?? (settings?.category ?? "Love")
        selectedBackgroundColor = userSetting.selectedBackgroundColor ?? (settings?.backgroundColor ?? "Blue")
        selectedGender = userSetting.selectedGender ?? (settings?.gender ?? "Male")
        selectedLanguage = userSetting.selectedLanguage ?? (settings?.language ?? "en")
        userSettings = userSetting
    }
    
    func saveSettings(category: String, color: String, gender: String, language: String) {
        userSettings.selectedCategory = category
        userSettings.selectedBackgroundColor = color
        userSettings.selectedGender = gender
        userSettings.selectedLanguage = language
        DataManager.shared.saveUserSettings(category: category, backgroundColor: color, gender: gender, language: language)
    }
    
    func allCategories() -> [String] {
        return DataManager.shared.fetchCategories()
    }
    
    func allThemes() -> [String] {
        return DataManager.shared.fetchThemes()
    }
    
}
