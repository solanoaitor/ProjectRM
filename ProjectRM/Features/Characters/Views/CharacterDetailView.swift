//
//  CharacterDetailView.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 29/3/25.
//

import SwiftUI
import Foundation

struct CharacterDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let character: CharacterRM
    @State private var showEpisodes = false

    private var infoItems: [(text: String, icon: String)] {
        [
            (!character.status.isEmpty ? ("Status: \(character.status)", "book") : nil),
            (!character.species.isEmpty ? ("Species: \(character.species)", "brain.head.profile") : nil),
            (!character.gender.isEmpty ? ("Gender: \(character.gender)", "person") : nil),
            (!character.type.isEmpty ? ("Type: \(character.type)", "tag") : nil),
            (!character.created.isEmpty ? ("Created: \(formattedDate(isoDate: character.created))", "calendar") : nil),
            (!character.origin.isEmpty ? ("Origin: \(character.origin)", "globe") : nil),
            (!character.location.isEmpty ? ("Last known location: \(character.location)", "location.fill") : nil),
            (character.episode.first.flatMap { "First seen in: Episode \($0.components(separatedBy: "/").last ?? "")" }.map { ($0, "film") })
        ].compactMap { $0 }
    }

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

                ForEach(infoItems, id: \.text) { item in
                    CharacterInfoLabel(text: item.text, icon: item.icon)
                }

                Button {
                    showEpisodes = true
                } label: {
                    Label("Episodes", systemImage: "film")
                        .font(.subheadline)
                        .padding(10)
                        .foregroundColor(.blue)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
            }
            .padding()
            .sheet(isPresented: $showEpisodes) {
                EpisodesSheetView(episodeURLs: character.episode)
            }
            .presentationDetents([.fraction(0.75)])
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Characters")
                }
                .onTapGesture {
                    dismiss()
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Details")
                    .font(.title2)
                    .bold()
            }
        }
    }
}
