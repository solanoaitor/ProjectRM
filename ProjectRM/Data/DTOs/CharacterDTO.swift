//
//  CharacterDTO.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: OriginDTO
    let location: LocationDTO
    let image: String
    let episode: [String]
}

struct CharacterResponseDTO: Decodable {
    let info: InfoDTO
    let results: [CharacterDTO]
}

struct OriginDTO: Decodable {
    let name: String
    let url: String
}

struct LocationDTO: Decodable {
    let name: String
    let url: String
}

struct InfoDTO: Decodable {
    let next: String?
}
