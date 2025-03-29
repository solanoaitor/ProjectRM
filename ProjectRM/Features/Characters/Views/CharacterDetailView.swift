//
//  CharacterDetailView.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 29/3/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: CharacterRM

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    ProgressView()
                }

                Text(character.name)
                    .font(.largeTitle)
                    .bold()

                Text("Estado: \(character.status)")
                Text("Especie: \(character.species)")
                Text("Género: \(character.gender)")
                Text("Origen: \(character.origin)")
                Text("Ubicación: \(character.location)")
            }
            .padding()
        }
        .navigationTitle("Detalles")
        .navigationBarTitleDisplayMode(.inline)
    }
}
