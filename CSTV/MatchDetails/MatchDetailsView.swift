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

                    Text("Major série 1") // Custom title text
                        .foregroundColor(.white) // Customize color
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)

                MatchTeamsView(homeTeam: match.opponents[safe: 0]?.opponent, awayTeam: match.opponents[safe: 1]?.opponent)

                // Date and Time
                Text("Hoje, 21:00")
                    .foregroundColor(.white)
                    .font(.system(size: 12)).bold()
                    .padding(.bottom, 10)

                // Players Section
                ForEach(0..<5) { _ in
                    HStack() {
                        PlayerCardView(playerName: "Nickname", realName: "Nome Jogador", side: .home)
                        PlayerCardView(playerName: "Nickname", realName: "Nome Jogador", side: .away)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true) // Hide the navigation bar entirely
    }

    init(match: Match) {
        self.match = match
    }
}



struct PlayerCardView: View {
    
    var playerName: String
    var realName: String
    var side: TeamMatchSide
    private let imageAlignment: Alignment
    private let cardAlignment: Alignment

    var body: some View {

        HStack(spacing: 10) {
            switch side {
                case .home:
                    Spacer()
                    Text(playerName)
                        .font(.headline)
                        .foregroundColor(.white)

                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(red: 196/255, green: 196/255, blue: 196/255))
                            .frame(width: 48, height: 48, alignment: imageAlignment)
                            .padding([.trailing, .bottom], 20)
                    }
                case .away:
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(red: 196/255, green: 196/255, blue: 196/255))
                            .frame(width: 48, height: 48, alignment: imageAlignment)
                            .padding([.leading, .bottom], 8)
                    }
                    Text(playerName)
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
            }
        }
        .frame(width: 200, height: 54, alignment: cardAlignment)
        .background(Color(red: 40/255, green: 40/255, blue: 55/255))
        .cornerRadius(12)
    }

    init(playerName: String, realName: String, side: TeamMatchSide) {
        self.playerName = playerName
        self.realName = realName
        self.side = side
        self.imageAlignment = side == .home ? .trailing : .leading
        self.cardAlignment = side == .home ? .leading : .trailing
    }
}

struct MatchDetailsView_Previews: PreviewProvider {

    static var previews: some View {
        let mockedLeague = League(name: "ESL Pro League")

        // Mock Teams
        let team1 = Team(name: "Team Liquid", imageURL: "https://example.com/team-liquid-logo.png")
        let team2 = Team(name: "Astralis", imageURL: "https://example.com/astralis-logo.png")

        // Mock Opponents
        let opponent1 = Opponent(opponent: team1)
        let opponent2 = Opponent(opponent: team2)

        // Mock Results
        let result1 = Result(score: 16, teamID: 1) // Team Liquid won
        let result2 = Result(score: 14, teamID: 2) // Astralis lost

        // Mock Match
        let mockedMatch = Match(
            beginAt: "2024-09-15T14:00:00Z",  // ISO 8601 format
            league: mockedLeague,
            opponents: [opponent1, opponent2],
            results: [result1, result2],
            status: "finished", serie: Serie(name: "North American Division")
        )
        MatchDetailsView(match: mockedMatch)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

