//
//  SplashScreen.swift
//  CSTV
//
//  Created by Lucas Brandão on 29/08/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack {
            Image("cs_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.darkBlue)
    }
}

struct ContentView: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            if isActive {
                MatchListView(viewModel: MatchListViewModel(service: MatchListService()))
            } else {
                SplashScreenView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
