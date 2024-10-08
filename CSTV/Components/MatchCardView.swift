//
//  MatchCardView.swift
//  CSTV
//
//  Created by Lucas Brandão on 24/08/24.
//

import SwiftUI

struct MatchCardView: View {

    let match: Match

    var body: some View {
        VStack {
            HStack {
                Spacer()
                MatchTimeView(text: match.timeString(), color: match.status.backgroundColor)
                    .padding(.top, -50)
                    .padding(.trailing, -20)
            }
            .padding([.top, .trailing], -2)

            MatchTeamsView(
                homeTeam: match.homeTeam,
                homeTeamScore: match.homeTeamScore,
                awayTeam: match.awayTeam,
                awayTeamScore: match.awayTeamScore
            )
            Spacer()
            Divider()
                .background(.gray)

            HStack {
                AsyncImageView(
                    url: URL(string: match.leagueImageUrl),
                    failureView: {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 20, height: 20)
                    }
                )

                Text(match.leagueAndSerie)
                    .foregroundColor(.lightGray)
                    .font(.system(size: 8))

                Spacer()
            }
            .padding([.leading], 12)
            .padding([.bottom], 8)
            .frame(height: 32)
        }
        .background(Color.midDarkBlue)
        .cornerRadius(16)
        .shadow(radius: 5)
    }

    init(match: Match) {
        self.match = match
    }
}
