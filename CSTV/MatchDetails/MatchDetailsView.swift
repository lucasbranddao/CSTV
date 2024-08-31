//
//  MatchDetailsView.swift
//  CSTV
//
//  Created by Lucas Brandão on 26/08/24.
//

import SwiftUI

enum TeamMatchSide {
    case home
    case away
}

struct MatchDetailsView: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MatchDetailsViewModel
    let match: Match

    var body: some View {
        ZStack {
            Color(red: 22/255, green: 22/255, blue: 30/255)
                .edgesIgnoringSafeArea(.all) // Ensure the background color covers the entire screen

            VStack(spacing: 20) {
                ZStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image("ic-arrow-left")
                        } .padding(.leading, 20)
                        Spacer()
                    }

                    Text(match.leagueAndSerie)
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)

                MatchTeamsView(homeTeam: match.homeTeam, awayTeam: match.awayTeam)

                Text(match.timeString())
                    .foregroundColor(.white)
                    .font(.system(size: 12)).bold()
                    .padding(.bottom, 10)

                ForEach(0..<5) { _ in
                    HStack() {
                        PlayerCardView(nickname: "", realName: "Nome Jogador", side: .home)
                        PlayerCardView(nickname: "Nickname", realName: "Nome Jogador", side: .away)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true) // Hide the navigation bar entirely
    }

    init(match: Match, viewModel: MatchDetailsViewModel) {
        self.match = match
        self.viewModel = viewModel
        self.viewModel.fetchPlayers()
    }
}
