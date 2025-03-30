//
//  CharacterInfoLabel.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 29/3/25.
//

import SwiftUI

struct CharacterInfoLabel: View {
    let text: String
    let icon: String

    var body: some View {
        Label(text, systemImage: icon)
            .padding(8)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
}
