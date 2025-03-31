//
//  CharacterViewModel.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

import Foundation

struct CharacterState {
    var characters: [CharacterRM] = []
}


@MainActor
class CharacterViewModel: ObservableObject {
    @Published var state = CharacterState()
    @Published var characters: [CharacterRM] = []
    @Published var isLoading = false
    @Published var searchText: String = ""

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
    
    var filteredCharacters: [CharacterRM] {
        guard !searchText.isEmpty else { return characters }
        return characters.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    func sortedFilteredCharacters(ascending: Bool) -> [CharacterRM] {
        let result = filteredCharacters
        return result.sorted {
            ascending ? $0.name < $1.name : $0.name > $1.name
        }
    }
}
