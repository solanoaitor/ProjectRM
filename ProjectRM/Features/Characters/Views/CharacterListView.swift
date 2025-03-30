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
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.characters) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            HStack(alignment: .center, spacing: 12) {
                                CachedAsyncImage(url: URL(string: character.image)!, size: CGSize(width: 60, height: 60))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(character.name)
                                        .font(.headline)
                                    Text(character.species)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }

                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("Characters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Characters")
                        .font(.largeTitle)
                        .bold()
                }
            }
        }
        .task {
            await viewModel.loadCharacters()
        }
    }
}
