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
                .background(Color(red: 40/255, green: 40/255, blue: 55/255))
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
                                .foregroundColor(Color(red: 108/255, green: 107/255, blue: 126/255))
                                .padding(paddingAlignment, 4)
                        }
                        AsyncImageView(url: imageUrl)
                            .frame(width: 48, height: 48, alignment: alignment)
                            .padding([paddingAlignment, .bottom], 20)
                    case .away:
                        AsyncImageView(url: imageUrl)
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
                                .foregroundColor(Color(red: 108/255, green: 107/255, blue: 126/255))
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

struct AsyncImageView: View {
    let url: URL?
    let placeholder: Image
    let errorImage: Image
    let contentMode: ContentMode

    init(url: URL?,
         placeholder: Image = Image("avatar"),
         errorImage: Image = Image(systemName: "exclamationmark.triangle"),
         contentMode: ContentMode = .fit) {
        self.url = url
        self.placeholder = placeholder
        self.errorImage = errorImage
        self.contentMode = contentMode
    }

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
                case .empty:
                    placeholder
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                case .failure:
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 196/255, green: 196/255, blue: 196/255))
                @unknown default:
                    placeholder
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
            }
        }
    }
}
