//
//  CharacterRepositoryImpl.swift.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

import Foundation

class CharacterRepositoryImpl: GetCharactersUseCase {
    func execute() async throws -> [CharacterRM] {
        var allCharacters: [CharacterRM] = []
        var nextPageURL: URL? = URL(string: "https://rickandmortyapi.com/api/character")

        do {
            while let url = nextPageURL {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoded = try JSONDecoder().decode(CharacterResponseDTO.self, from: data)
                let characters = decoded.results.map { $0.toDomain() }
                allCharacters.append(contentsOf: characters)

                if let next = decoded.info.next {
                    nextPageURL = URL(string: next)
                } else {
                    nextPageURL = nil
                }
            }
        } catch {
            print("Error fetching characters: \(error.localizedDescription)")
            throw error
        }

        return allCharacters
    }
}
