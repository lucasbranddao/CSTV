//
//  ListView.swift
//  CSTV
//
//  Created by Lucas Brandão on 24/08/24.
//

import SwiftUI

fileprivate enum Destination: Hashable {
    case matchDetails
}

struct MatchListView: View {

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    Spacer()
                    NavigationLink(value: Destination.matchDetails) {
                        MatchCardView()
                            .padding([.leading, .trailing], 24)
                            .frame(height: 176)
                    }
                }
            }
            .background(Color(red: 22/255, green: 22/255, blue: 30/255))
            .navigationTitle("Partidas")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                    case .matchDetails:
                        MatchDetailsView()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


#Preview {
    MatchListView()
}
