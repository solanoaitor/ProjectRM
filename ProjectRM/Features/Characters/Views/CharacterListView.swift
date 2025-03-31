//
//  CharacterListView.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject var viewModel = CharacterViewModel()
    @State private var isAscending = true
    
    init(characters: [CharacterRM]) {
        _viewModel = StateObject(wrappedValue: CharacterViewModel(preloadedCharacters: characters))
    }

    var body: some View {
        NavigationStack {
            List(viewModel.sortedFilteredCharacters(ascending: isAscending)) { character in
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    CharacterRowView(character: character)
                }
                .buttonStyle(PlainButtonStyle())
                .listSectionSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Characters")
                        .font(.title2)
                        .bold()
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAscending.toggle()
                    }) {
                        HStack(spacing: 4) {
                            Text("Order")
                            Image(systemName: isAscending ? "arrow.down" : "arrow.up")
                        }
                        .foregroundColor(.blue)
                        .font(.subheadline)
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search character")
        }
        .task {
            await viewModel.loadCharacters()
        }
    }
}
