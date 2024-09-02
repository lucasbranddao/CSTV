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
                .edgesIgnoringSafeArea(.all)
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

                    if let homePlayers = $viewModel.players.wrappedValue[safe: 0],
                       homePlayers.count >= 5,
                       let awayPlayers = $viewModel.players.wrappedValue[safe: 1],
                       awayPlayers.count >= 5 {
                        ForEach(0..<5) { i in
                            HStack() {
                                let homePlayer = homePlayers[i]
                                let awayPlayer = awayPlayers[i]
                                PlayerCardView(
                                    nickname: homePlayer.name,
                                    realName: homePlayer.firstName + " " + homePlayer.lastName,
                                    imageUrl: URL(string: homePlayer.imageURL ?? ""),
                                    side: .home
                                )
                                PlayerCardView(
                                    nickname: awayPlayer.name,
                                    realName: awayPlayer.firstName + " " + awayPlayer.lastName,
                                    imageUrl: URL(string: homePlayer.imageURL ?? ""),
                                    side: .away
                                )
                            }

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
        self.viewModel.fetchPlayers(homeId: match.homeTeam?.id ?? 0, awayId: match.awayTeam?.id ?? 0)
    }
}
