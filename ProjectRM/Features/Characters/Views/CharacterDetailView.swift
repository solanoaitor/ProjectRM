//
//  CharacterDetailView.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 29/3/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: CharacterRM
    @State private var showEpisodes = false

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

                let infoItems: [(text: String, icon: String)] = [
                    (!character.status.isEmpty ? ("Status: \(character.status)", "book") : nil),
                    (!character.species.isEmpty ? ("Species: \(character.species)", "brain.head.profile") : nil),
                    (!character.gender.isEmpty ? ("Gender: \(character.gender)", "person") : nil),
                    (!character.type.isEmpty ? ("Type: \(character.type)", "tag") : nil),
                    (!character.created.isEmpty ? ("Created: \(formattedDate(from: character.created))", "calendar") : nil),
                    (!character.origin.isEmpty ? ("Origin: \(character.origin)", "globe") : nil),
                    (!character.location.isEmpty ? ("Last known location: \(character.location)", "location.fill") : nil),
                    (character.episode.first.flatMap { "First seen in: Episode \($0.components(separatedBy: "/").last ?? "")" }.map { ($0, "film") })
                ].compactMap { $0 }

                ForEach(infoItems, id: \.text) { item in
                    CharacterInfoLabel(text: item.text, icon: item.icon)
                }

                Button("Episodes") {
                    showEpisodes = true
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .padding()
            .sheet(isPresented: $showEpisodes) {
                EpisodesSheetView(episodeURLs: character.episode)
            }
            .presentationDetents([.fraction(0.75)])
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func formattedDate(from isoDate: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: isoDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return isoDate
    }
}
