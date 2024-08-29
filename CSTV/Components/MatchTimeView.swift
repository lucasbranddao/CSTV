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
            Color.blue // Background color of the view
                .cornerRadius(20) // Rounded corners with a radius of 20

            Text(text)
                .foregroundColor(color)
                .font(. system(size: 10))
                .fontWeight(.bold)
                .padding(.bottom, 9)
                .padding(.leading, 12)// Padding to position the label in the bottom-left corner
        }
        .frame(width: 80, height: 80) // Set the size of the view
    }

    init(text: String, color: Color) {
        self.text = text
        self.color = color
    }
}
