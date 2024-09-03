//
//  MatchTeamsView.swift
//  CSTV
//
//  Created by Lucas Brandão on 26/08/24.
//

import SwiftUI

struct MatchTeamsView: View {

    let homeTeam: Team
    let homeTeamScore: Int
    let awayTeam: Team
    let awayTeamScore: Int

    var body: some View {
        HStack(spacing: 20) {
            TeamView(name: homeTeam.name, imageUrl: URL(string: homeTeam.imageURL ?? ""), score: homeTeamScore, side: .home)
                .frame(width: 80, height: 100)
                .multilineTextAlignment(.center)

            Text("VS")
                .foregroundColor(.white).opacity(0.5)
                .font(.system(size: 12))

            TeamView(name: awayTeam.name, imageUrl: URL(string: awayTeam.imageURL ?? ""), score: awayTeamScore, side: .away)
                .frame(width: 80, height: 100)
                .multilineTextAlignment(.center)
        }
    }

    init(
        homeTeam: Team?,
        homeTeamScore: Int,
        awayTeam: Team?,
        awayTeamScore: Int
    ) {
        self.homeTeam = homeTeam ?? Team(name: "--", imageURL: nil, id: 0)
        self.awayTeam = awayTeam ?? Team(name: "--", imageURL: nil, id: 0)
        self.homeTeamScore = homeTeamScore
        self.awayTeamScore = awayTeamScore
    }
}
