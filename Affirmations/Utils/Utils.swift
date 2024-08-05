//
//  Constants.swift
//  Affirmations
//
//  Created by sherzodbek on 8/4/24.
//

import Foundation
import SwiftUI

struct Utils {
    var defaultTabs: [OnboardingModel] = [
        OnboardingModel(title: "What category would you like to choose?", firstBtnText: "Love", secondBtnText: "Friendship"),
        OnboardingModel(title: "What background color do you prefer?", firstBtnText: "Blue", secondBtnText: "Red"),
        OnboardingModel(title: "What is your gender?", firstBtnText: "Male", secondBtnText: "Female")
    ]
    
    let defaultCategory: String = "Love"
    let defaultTheme: String = "Blue"
    let defaultLanguage: String = "en"
    
    let defaultAffirmations: [String: [String]] = [
        "Love": [
            "I am worthy of love and deserve to receive love in abundance",
            "My heart is open to giving and receiving love",
            "I am surrounded by love every day and in every way",
            "I attract love and loving relationships into my life",
            "Love flows to me and through me effortlessly",
            "I radiate love and others reflect love back to me",
            "My relationships are filled with love, happiness, and respect",
            "I am grateful for the love that surrounds me",
            "Love comes to me easily and effortlessly",
            "I am a magnet for loving and fulfilling relationships"
        ],
        "Friendship": [
            "I am surrounded by supportive and loving friends",
            "I attract positive and loyal friendships into my life",
            "My friends and I share mutual respect and trust",
            "I am a kind and caring friend, and I receive the same in return",
            "My friendships are filled with joy, laughter, and understanding",
            "I am grateful for the amazing friends in my life",
            "I nurture and cherish my friendships",
            "I attract friends who support and uplift me",
            "My friends and I grow together in love and harmony",
            "I am a magnet for genuine and lasting friendships"
        ]
    ]
    
    let defaultThemes: [String] = [
        "Blue",
        "Red"
    ]
    
    func selectedLanguage(_ key: String) -> LocalizedStringKey {
        switch key {
        case "en":
            return LocalizedStringKey("English")
        case "ru":
            return LocalizedStringKey("Russian")
        default:
            return "unknown"
        }
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:]) { language in
                print(language)
            }
        }
    }
    
}

public enum SelectedLanguage: String {
    case english = "en"
    case russian = "ru"
}

func color(from theme: String) -> Color {
    switch theme.lowercased() {
    case "red": return .red
    case "blue": return .blue
    default: return .clear
    }
}
