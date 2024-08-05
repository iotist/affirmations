//
//  OnboardingViewModel.swift
//  Affirmations
//
//  Created by sherzodbek on 8/1/24.
//

import SwiftUI
import Combine

class OnboardingViewModel: ObservableObject {
    @Published var category: String = ""
    @Published var backgroundColor: String = ""
    @Published var gender: String = ""
    @Published var selectedButton: [(iteration: Int, button: Int)] = []
    @Published var isAnyButtonSelected: Bool = false
    @Published var userSettings: UserSetting = UserSetting()
    
    @Published var defaultTabs: [OnboardingModel] = [
        OnboardingModel(title: "What category would you like to choose?", firstBtnText: "Love", secondBtnText: "Friendship"),
        OnboardingModel(title: "What background color do you prefer?", firstBtnText: "Blue", secondBtnText: "Red"),
        OnboardingModel(title: "What is your gender?", firstBtnText: "Male", secondBtnText: "Female")
    ]
    
    func handleButtonTap(iteration: Int, button: Int, item: OnboardingModel) {
        selectedButton.append((iteration: iteration, button: button))
        defaultTabs[iteration].selectedButton = button
        isAnyButtonSelected = defaultTabs.contains { $0.selectedButton != nil }
        
        switch iteration {
        case 0:
            category = button == 1 ? item.firstBtnText : item.secondBtnText
        case 1:
            backgroundColor = button == 1 ? item.firstBtnText : item.secondBtnText
        case 2:
            gender = button == 1 ? item.firstBtnText : item.secondBtnText
        default:
            break
        }
    }
    
    func saveSettings() {
        DataManager.shared.saveUserSettings(
            category: category,
            backgroundColor: backgroundColor,
            gender: gender,
            language: Locale.current.language.languageCode?.identifier ?? "en"
        )
        
    }
}
