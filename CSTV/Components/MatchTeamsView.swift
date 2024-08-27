//
//  MatchTeamsView.swift
//  CSTV
//
//  Created by Lucas Brandão on 26/08/24.
//

import SwiftUI

struct MatchTeamsView: View {
    var body: some View {
        HStack(spacing: 20) {
            TeamView(name: "Vitality")
                .frame(width: 54, height: 82)

            Text("VS")
                .foregroundColor(.white).opacity(0.5)
                .font(.system(size: 12))

            TeamView(name: "SK Gaming")
                .frame(width: 54, height: 82)
        }
    }
}

struct TeamView: View {
    let name: String
    var body: some View {
        VStack {
            Circle()
                .fill(Color.gray)
            Spacer()
            Text(name)
                .foregroundColor(.white)
                .font(.system(size: 10))
                .padding(.bottom, 8)

        }
    }

    init(name: String) {
        self.name = name
    }
}
