//
//  ImagePreloader.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

import Foundation

protocol ImagePreloader {
    func preload(from urls: [String]) async
}

class DefaultImagePreloader: ImagePreloader {
    func preload(from urls: [String]) async {
        await withTaskGroup(of: Void.self) { group in
            for urlString in urls {
                guard let url = URL(string: urlString) else { continue }

                group.addTask {
                    let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
                    _ = try? await URLSession.shared.data(for: request)
                }
            }
        }
    }
}
