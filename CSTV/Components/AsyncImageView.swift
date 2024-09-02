//
//  AsyncImageView.swift
//  CSTV
//
//  Created by Lucas Brandão on 02/09/24.
//

import SwiftUI

struct AsyncImageView<FailureView: View>: View {
    let url: URL?
    let placeholder: Image
    let errorImage: Image
    let contentMode: ContentMode
    let failureView: FailureView

    init(url: URL?,
         placeholder: Image = Image("avatar"),
         errorImage: Image = Image(systemName: "exclamationmark.triangle"),
         contentMode: ContentMode = .fit,
         @ViewBuilder failureView: () -> FailureView) {
        self.url = url
        self.placeholder = placeholder
        self.errorImage = errorImage
        self.contentMode = contentMode
        self.failureView = failureView()
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
                    failureView
                @unknown default:
                    placeholder
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
            }
        }
    }
}
