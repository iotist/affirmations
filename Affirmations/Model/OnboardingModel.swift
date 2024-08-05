//
//  OnboardingModel.swift
//  Affirmations
//
//  Created by sherzodbek on 8/3/24.
//

import SwiftUI

struct OnboardingModel: Identifiable {
    var id = UUID()
    var title: String
    var firstBtnText: String
    var secondBtnText: String
    var selectedButton: Int? = nil
}
