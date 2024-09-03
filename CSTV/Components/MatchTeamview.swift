//
//  MatchTeamview.swift
//  CSTV
//
//  Created by Lucas Brandão on 03/09/24.
//

import SwiftUI

struct TeamView: View {
    let name: String
    let imageUrl: URL?
    let score: Int
    let side: TeamMatchSide
    var body: some View {
        HStack(spacing: 12) {
            switch side {
                case .home:
                    TeamLogoAndNameView(name: name, imageUrl: imageUrl)
                        .frame(maxHeight: 85)
                    Text("\(score)")
                        .foregroundColor(.white)
                        .font(.system(size: 32))

                case .away:
                    Text("\(score)")
                        .foregroundColor(.white)
                        .font(.system(size: 32))
                    TeamLogoAndNameView(name: name, imageUrl: imageUrl)
                        .frame(maxHeight: 85)
            }
        }
    }

    init(
        name: String,
        imageUrl: URL?,
        score: Int,
        side: TeamMatchSide
    ) {
        self.name = name
        self.imageUrl = imageUrl
        self.score = score
        self.side = side
    }
}

struct TeamLogoAndNameView: View {

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
                .frame(minWidth: 48, maxHeight: .infinity)
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
