//
//  ImageCache.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

import UIKit

class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}
