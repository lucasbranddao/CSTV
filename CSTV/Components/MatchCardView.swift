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
                MatchTimeView()
                    .padding(.top, -50)
                    .padding(.trailing, -20)
            }
            .padding([.top, .trailing], -2)

            MatchTeamsView(homeTeam: match.mapHomeTeam(), awayTeam: match.mapHomeTeam())
            Spacer()
            Divider()
                .background(.gray)

            HStack {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 20, height: 20)

                Text(match.mapLeagueSerie())
                    .foregroundColor(.gray)
                    .font(.system(size: 8))

                Spacer()
            }
            .padding([.leading], 12)
            .padding([.bottom], 8)
            .frame(height: 32)
        }
        .background(Color(red: 39/255, green: 38/255, blue: 57/255))
        .cornerRadius(16)
        .shadow(radius: 5)
    }

    init(match: Match) {
        self.match = match
    }
}
