//
//  MatchTimeView.swift
//  CSTV
//
//  Created by Lucas Brandão on 24/08/24.
//

import SwiftUI

struct MatchTimeView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.blue // Background color of the view
                .cornerRadius(20) // Rounded corners with a radius of 20

            Text("AGORA")
                .foregroundColor(.white)
                .font(. system(size: 10))
                .fontWeight(.bold)
                .padding(.bottom, 9)
                .padding(.leading, 12)// Padding to position the label in the bottom-left corner
        }
        .frame(width: 80, height: 80) // Set the size of the view
    }
}
