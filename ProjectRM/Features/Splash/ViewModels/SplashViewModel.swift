//
//  SplashViewModel.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

import Foundation

@MainActor
class SplashViewModel: ObservableObject {
    private let preloadImagesUseCase: PreloadCharacterImagesUseCase
    private let characterRepository: CharacterRepositoryImpl
    private let imagePreloader: ImagePreloader
    @Published var characters: [CharacterRM] = []
    @Published var errorMessage: String? = nil

    init(
        preloadImagesUseCase: PreloadCharacterImagesUseCase = PreloadCharacterImagesUseCaseImpl(),
        characterRepository: CharacterRepositoryImpl = CharacterRepositoryImpl(),
        imagePreloader: ImagePreloader = DefaultImagePreloader()
    ) {
        self.preloadImagesUseCase = preloadImagesUseCase
        self.characterRepository = characterRepository
        self.imagePreloader = imagePreloader
    }

    func preloadImages() async {
        do {
            let allCharacters = try await characterRepository.execute()
            characters = allCharacters
            let imageUrls = allCharacters.map { $0.image }
            await imagePreloader.preload(from: imageUrls)
        } catch {
            await MainActor.run {
                self.errorMessage = "The characters could not be loaded. Please try again later."
            }
        }
    }
}
