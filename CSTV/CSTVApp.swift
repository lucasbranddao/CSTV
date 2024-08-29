//
//  CSTVApp.swift
//  CSTV
//
//  Created by Lucas Brandão on 24/08/24.
//

import SwiftUI

@main
struct CSTVApp: App {
    

    init() {
        setupAppearance()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    private func setupAppearance() {
        // Configure UINavigationBar appearance
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithTransparentBackground()
        navAppearance.backgroundColor = .clear
        navAppearance.shadowColor = .clear
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Cor do título
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }
}
