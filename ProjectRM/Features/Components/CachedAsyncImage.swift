//
//  CachedAsyncImage.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: URL
    let size: CGSize

    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipShape(Circle())
            } else {
                ProgressView()
                    .frame(width: size.width, height: size.height)
                    .onAppear {
                        Task {
                            if let cached = ImageCache.shared.object(forKey: url as NSURL) {
                                image = cached
                            } else {
                                do {
                                    let (data, _) = try await URLSession.shared.data(from: url)
                                    if let img = UIImage(data: data) {
                                        ImageCache.shared.setObject(img, forKey: url as NSURL)
                                        image = img
                                    }
                                } catch {
                                    print("Image load failed")
                                }
                            }
                        }
                    }
            }
        }
    }
}
