//
//  CharacterRowView.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 30/3/25.
//

import SwiftUI

struct CharacterRowView: View {
    let character: CharacterRM

    var body: some View {
        HStack(spacing: 12) {
            CachedAsyncImage(
                url: URL(string: character.image)!,
                size: CGSize(width: 50, height: 50)
            )
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(character.name)
                    .font(.system(.body, design: .default).weight(.medium))
                Text(character.species)
                    .font(.system(.caption))
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}
