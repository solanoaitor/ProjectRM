//
//  PreloadCharacterImagesUseCaseImpl.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

import Foundation

class PreloadCharacterImagesUseCaseImpl: PreloadCharacterImagesUseCase {
    let imagePreloader: ImagePreloader

    init(imagePreloader: ImagePreloader = DefaultImagePreloader()) {
        self.imagePreloader = imagePreloader
    }

    func execute() async throws {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(CharacterResponseDTO.self, from: data)
        let imageUrls = decoded.results.map { $0.image }
        await imagePreloader.preload(from: imageUrls)
    }
}
