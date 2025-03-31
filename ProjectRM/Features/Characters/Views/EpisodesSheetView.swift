//
//  EpisodesSheetView.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 29/3/25.
//

import SwiftUI

struct EpisodesSheetView: View {
    let episodeURLs: [String]
    
    @State private var episodes: [EpisodeDTO] = []

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Episodes")
                        .font(.headline)
                        .padding(.top, 12)
                    Spacer()
                }

                Divider()

                List(episodes) { episode in
                    VStack(alignment: .leading) {
                        Text(episode.name)
                            .font(.headline)
                        Text(episode.episode)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .listStyle(.plain)
            }
            .padding(.horizontal)
        }
        .presentationDetents([.fraction(0.75)])
        .task {
            await fetchEpisodes()
        }
    }

    func fetchEpisodes() async {
        var loadedEpisodes: [EpisodeDTO] = []

        for urlString in episodeURLs {
            guard let url = URL(string: urlString) else { continue }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let episode = try JSONDecoder().decode(EpisodeDTO.self, from: data)
                loadedEpisodes.append(episode)
            } catch {
                print("Error loading episode from \(urlString): \(error)")
            }
        }
        episodes = loadedEpisodes.sorted { $0.id < $1.id }
    }
}
