//
//  UserSettings.swift
//  Affirmations
//
//  Created by sherzodbek on 8/5/24.
//

import SwiftUI
import Combine

final class UserSetting: ObservableObject {
    @Published var selectedCategory: String?
    @Published var selectedBackgroundColor: String?
    @Published var selectedGender: String?
    @Published var selectedLanguage: String?
    
    
}
