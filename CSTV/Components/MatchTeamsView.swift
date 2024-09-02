//
//  MatchTeamsView.swift
//  CSTV
//
//  Created by Lucas Brandão on 26/08/24.
//

import SwiftUI

struct MatchTeamsView: View {

    let homeTeam: Team
    let awayTeam: Team

    var body: some View {
        HStack(spacing: 20) {
            TeamView(name: homeTeam.name, imageUrl: URL(string: homeTeam.imageURL ?? ""))
                .frame(width: 54, height: 100)
                .multilineTextAlignment(.center)

            Text("VS")
                .foregroundColor(.white).opacity(0.5)
                .font(.system(size: 12))

            TeamView(name: homeTeam.name, imageUrl: URL(string: homeTeam.imageURL ?? ""))
                .frame(width: 54, height: 100)
                .multilineTextAlignment(.center)
        }
    }

    init(homeTeam: Team?, awayTeam: Team?) {
        self.homeTeam = homeTeam ?? Team(name: "--", imageURL: nil, id: 0)
        self.awayTeam = awayTeam ?? Team(name: "--", imageURL: nil, id: 0)
    }
}

struct TeamView: View {
    let name: String
    let imageUrl: URL?
    var body: some View {
        VStack {
            AsyncImageView(
                url: imageUrl,
                failureView: {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 60, height: 60)
                }
            )
            Spacer()
            Text(name)
                .foregroundColor(.white)
                .font(.system(size: 10))
                .padding(.bottom, 8)
                .frame(maxHeight: .infinity)

        }
    }

    init(
        name: String,
        imageUrl: URL?
    ) {
        self.name = name
        self.imageUrl = imageUrl
    }
}
