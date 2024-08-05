//
//  MainView.swift
//  Affirmations
//
//  Created by sherzodbek on 8/1/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel = MainViewModel()
    @EnvironmentObject var userSettings: UserSetting
    
    var body: some View {
        NavigationStack {
            ZStack {
                color(from: (userSettings.selectedBackgroundColor ?? viewModel.userSettings.selectedBackgroundColor) ?? "blue")
                    .ignoresSafeArea()
                
                    GeometryReader { geometry in
                        TabView {
                            ForEach(viewModel.affirmations) { affirmation in
                                if let text = affirmation.text {
                                    VStack {
                                        Text(LocalizedStringKey(text))
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                    }
                                    .background(color(from: (userSettings.selectedBackgroundColor ?? viewModel.userSettings.selectedBackgroundColor) ?? "blue"))
                                    .frame(width: geometry.size.width)
                                    .rotationEffect(.init(degrees: -90))
                                    .ignoresSafeArea(.all, edges: .top)
                                }
                            }
                        }
                        .rotationEffect(.degrees(90))
                        .frame(width: geometry.size.height)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(width: geometry.size.width)
                    }
                    .ignoresSafeArea(.all, edges: .top)
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingsView(viewModel: SettingsViewModel(userSettings))
                    } label: {
                        Image(systemName: "gear").foregroundStyle(.white)
                    }

                }
            }
        }
    }
}

//#Preview {
//    MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}

