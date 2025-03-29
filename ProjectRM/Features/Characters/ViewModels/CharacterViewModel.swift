//
//  CharacterViewModel.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

import Foundation

struct CharacterState {
    var characters: [CharacterRM] = []
    // otras propiedades como loading, error, etc.
}


@MainActor
class CharacterViewModel: ObservableObject {
    @Published var state = CharacterState()
    @Published var characters: [CharacterRM] = []
    @Published var isLoading = false

    private let getCharactersUseCase: GetCharactersUseCase

    init(getCharactersUseCase: GetCharactersUseCase = CharacterRepositoryImpl()) {
        self.getCharactersUseCase = getCharactersUseCase
    }
    
    init(preloadedCharacters: [CharacterRM]) {
        self.characters = preloadedCharacters
        self.getCharactersUseCase = CharacterRepositoryImpl()
    }

    func loadCharacters() async {
        isLoading = true
        do {
            let result = try await getCharactersUseCase.execute()
            characters = result
            self.state.characters = result
        } catch {
            print("Error: \(error)")
        }
        isLoading = false
    }
}
