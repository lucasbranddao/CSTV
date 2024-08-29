//
//  MatchTimeView.swift
//  CSTV
//
//  Created by Lucas Brandão on 24/08/24.
//

import SwiftUI

struct MatchTimeView: View {

    let text: String
    let color: Color

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            color
                .cornerRadius(20)

            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 10))
                .fontWeight(.bold)
                .padding(.bottom, 9)
                .padding(.leading, 8)
        }
        .frame(width: 100, height: 80)
    }

    init(text: String, color: Color) {
        self.text = text
        self.color = color
    }
}
