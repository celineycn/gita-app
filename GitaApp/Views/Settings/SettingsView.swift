//
//  SettingsView.swift
//  GitaApp
//
//  Created by Celine on 1/21/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @State private var selectedLanguage: Language
    
    init() {
        _selectedLanguage = State(initialValue: LanguageManager.shared.currentLanguage)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $selectedLanguage) {
                        ForEach(Language.allCases, id: \.self) { language in
                            HStack {
                                Text(language.emoji)
                                Text(language.displayName)
                            }
                            .tag(language)
                        }
                    } label: {
                        Label {
                            LocalizedText("settings.language", comment: "Language setting label")
                        } icon: {
                            Image(systemName: "globe")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedLanguage) { _, newValue in
                        languageManager.setLanguage(newValue)
                        // 发送语言变化通知
                        NotificationCenter.default.post(name: Notification.Name("LanguageChanged"), object: nil)
                    }
                    
                    if languageManager.isUsingCustomLanguage {
                        Button {
                            languageManager.resetToSystemLanguage()
                            selectedLanguage = languageManager.currentLanguage
                        } label: {
                            Label {
                                LocalizedText("settings.followSystem", comment: "Follow system language button")
                            } icon: {
                                Image(systemName: "arrow.triangle.2.circlepath")
                            }
                        }
                    }
                } header: {
                    LocalizedText("settings.language", comment: "Language section header")
                } footer: {
                    if languageManager.isUsingCustomLanguage {
                        LocalizedText("settings.currentlyCustom", comment: "Currently using custom language setting")
                    } else {
                        LocalizedText("settings.currentlySystem", comment: "Currently following system language")
                    }
                }
            }
            .navigationTitle(Text(getLocalizedString("tab.settings")))
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func getLocalizedString(_ key: String) -> String {
        let languageCode = languageManager.currentLanguage.rawValue
        
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(key, bundle: bundle, comment: "")
        }
        
        return NSLocalizedString(key, comment: "")
    }
} 