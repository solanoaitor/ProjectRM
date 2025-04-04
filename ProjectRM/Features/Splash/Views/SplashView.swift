//
//  ContentView.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 26/3/25.
//

import SwiftUI

struct SplashView: View {
    @StateObject var viewModel = SplashViewModel()
    @State private var isActive = false
    @State private var isLoading = false

    var body: some View {
        NavigationStack {
            if isActive {
                CharacterListView(characters: viewModel.characters)
            } else {
                VStack {
                    Image("mainFoto")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    ProgressView("Loading characters")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(.top, 20)
                        
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .ignoresSafeArea()
                .task {
                    await viewModel.preloadImages()
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
        .preferredColorScheme(.light)
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}

#Preview {
    SplashView()
}
