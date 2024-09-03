//
//  PlayerCardView.swift
//  CSTV
//
//  Created by Lucas Brandão on 29/08/24.
//

import SwiftUI

struct PlayerCardView: View {

    var nickname: String
    var realName: String
    var imageUrl: URL?
    var side: TeamMatchSide
    private let alignment: Alignment
    private let paddingAlignment: Edge.Set
    private let textAlignment: HorizontalAlignment

    var body: some View {
        ZStack {
            Spacer()
                .frame(width: 200, height: 54)
                .background(Color.midDarkBlue)
                .cornerRadius(12)
                .padding(paddingAlignment, 8)

            HStack(spacing: 10) {
                switch side {
                    case .home:
                        Spacer()
                        VStack(alignment: textAlignment) {
                            Text(nickname)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .bold()
                                .padding(paddingAlignment, 4)
                            Text(realName)
                                .font(.system(size: 12))
                                .foregroundColor(Color.lightBlue)
                                .padding(paddingAlignment, 4)
                        }
                        AsyncImageView(
                            url: imageUrl,
                            failureView: {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.lightGray)
                            }
                        )
                        .frame(width: 48, height: 48, alignment: alignment)
                        .padding([paddingAlignment, .bottom], 20)
                    case .away:
                        AsyncImageView(
                            url: imageUrl,
                            failureView: {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.lightGray)
                            }
                        )
                        .frame(width: 48, height: 48, alignment: alignment)
                        .padding([paddingAlignment, .bottom], 20)
                        VStack(alignment: textAlignment) {
                            Text(nickname)
                                .font(.system(size: 14))
                                .bold()
                                .foregroundColor(.white)
                                .padding(paddingAlignment, 4)
                            Text(realName)
                                .font(.system(size: 12))
                                .foregroundColor(Color.lightBlue)
                                .padding(paddingAlignment, 4)
                        }
                        Spacer()

                }
            }
        }
    }

    init(
        nickname: String,
        realName: String,
        imageUrl: URL?,
        side: TeamMatchSide
    ) {
        self.nickname = nickname
        self.realName = realName
        self.imageUrl = imageUrl
        self.side = side
        self.alignment = side == .home ? .trailing : .leading
        self.paddingAlignment = side == .home ? .trailing : .leading
        self.textAlignment = side == .home ? .trailing : .leading
    }
}
