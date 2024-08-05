//
//  SettingsView.swift
//  Affirmations
//
//  Created by sherzodbek on 8/1/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SettingsViewModel
    @State private var showAlert = false
    @State private var isSaved = false
    
    var body: some View {
        VStack(spacing: 20) {
            Form {
                Section(header: Text("Category")) {
                    Picker("Select category", selection: $viewModel.selectedCategory) {
                        ForEach(viewModel.allCategories(), id: \.self) { category in
                            Text(LocalizedStringKey(category)).tag(category)
                        }
                    }
                }
                
                Section(header: Text("Background color")) {
                    Picker("Select background color", selection: $viewModel.selectedBackgroundColor) {
                        ForEach(viewModel.allThemes(), id: \.self) { theme in
                            Text(LocalizedStringKey(theme)).tag(theme)
                        }
                    }
                }
                
                Section(header: Text("Gender")) {
                    Picker("Select gender", selection: $viewModel.selectedGender) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                    }
                }
                
                Section(header: Text("Language")) {
                    Button(action: Utils().openSettings) {
                        Text(Utils().selectedLanguage(Locale.current.language.languageCode?.identifier ?? "en"))
                    }
                    .padding()
                }
            }
            
            Button(action: {
                viewModel.saveSettings(
                    category: viewModel.selectedCategory,
                    color: viewModel.selectedBackgroundColor,
                    gender: viewModel.selectedGender,
                    language: viewModel.selectedLanguage
                )
                isSaved = true
            }) {
                Text("Save changes")
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .transition(.opacity)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    if isSaved {
                        dismiss()
                    } else {
                        showAlert = true
                    }
                }) {
                    Image(systemName: "chevron.left")
                                    .foregroundColor(.blue)
                    Text(LocalizedStringKey("Back"))
                        .font(.system(size: 18))
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(LocalizedStringKey("Would you like to save changes?")), message: Text(""),
                primaryButton: .default(Text(LocalizedStringKey("Save")), action: {
                    viewModel.saveSettings(
                        category: viewModel.selectedCategory,
                        color: viewModel.selectedBackgroundColor,
                        gender: viewModel.selectedGender,
                        language: viewModel.selectedLanguage
                    )
                    dismiss()
                }),
                secondaryButton: .cancel(Text(LocalizedStringKey("Cancel")),
                                         action: {
                                             dismiss()
                                         })
            )
        }
        
     Spacer()
    }
}

