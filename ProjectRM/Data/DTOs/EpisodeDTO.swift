//
//  EpisodeDTO.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 29/3/25.
//

import Foundation

struct EpisodeDTO: Decodable, Identifiable {
    let id: Int
    let name: String
    let episode: String
}
