//
//  OnboardingView.swift
//  Affirmations
//
//  Created by sherzodbek on 8/1/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    @ObservedObject var viewModel = OnboardingViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            VStack() {
                HStack {
                    if selectedTab != 0 {
                        Button(action:{
                            if selectedTab > 0 {
                                selectedTab -= 1
                                viewModel.isAnyButtonSelected = true
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.gray)
                        }
                    }
                    Spacer()
                }
                .padding()
                
                TabView(selection: $selectedTab) {
                    ForEach(Array(viewModel.defaultTabs.enumerated()), id: \.offset) { index, item in
                        VStack {
                            Text(LocalizedStringKey(viewModel.defaultTabs[index].title))
                                .font(.title)
                                .bold()
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                withAnimation {
                                    viewModel.handleButtonTap(iteration: index, button: 1, item: item)
                                }
                            }) {
                                Text(LocalizedStringKey(viewModel.defaultTabs[index].firstBtnText))
                                    .foregroundColor(item.selectedButton == 1 ? .white : Color.purple)
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(item.selectedButton == 1 ? Color.purple : .white)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.purple, lineWidth: 1)
                                    )
                            }
                            
                            Button(action: {
                                withAnimation {
                                    viewModel.handleButtonTap(iteration: index, button: 2, item: item)
                                }
                            }) {
                                Text(LocalizedStringKey(viewModel.defaultTabs[index].secondBtnText))
                                    .foregroundColor(item.selectedButton == 2 ? .white : Color.purple)
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(item.selectedButton == 2 ? Color.purple : .white)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.purple, lineWidth: 1)
                                    )
                            }
                            
                        }
                        .padding()
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .ignoresSafeArea()
                
                Button(action: {
                    if selectedTab < viewModel.defaultTabs.count - 1 {
                        selectedTab += 1
                    } else {
                        viewModel.saveSettings()
                        isOnboarding = false
                    }
                    
                    viewModel.isAnyButtonSelected = viewModel.defaultTabs[selectedTab].selectedButton != nil
                }) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(viewModel.isAnyButtonSelected ? Color.purple : .gray)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.white, lineWidth: 1)
                        )
                }
                .disabled(!viewModel.isAnyButtonSelected)
                .padding()
            }
            .background(
                LinearGradient(colors: [Color.purple.opacity(0.8), Color.white], startPoint: .bottom, endPoint: .top)
            )
        }
    }
}

#Preview {
    NavigationView {
        OnboardingView()
    }
    
}
