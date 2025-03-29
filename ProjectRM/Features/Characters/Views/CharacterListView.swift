//
//  CharacterListView.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject var viewModel = CharacterViewModel()
    
    init(characters: [CharacterRM]) {
        _viewModel = StateObject(wrappedValue: CharacterViewModel(preloadedCharacters: characters))
    }

    var body: some View {
        NavigationStack {
            List(viewModel.characters) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    HStack {
                        CachedAsyncImage(url: URL(string: character.image)!, size: CGSize(width: 60, height: 60))

                        VStack(alignment: .leading) {
                            Text(character.name).font(.headline)
                            Text(character.species).font(.subheadline).foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Characters")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            await viewModel.loadCharacters()
        }
    }
}
