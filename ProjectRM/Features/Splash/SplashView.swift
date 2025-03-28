//
//  ContentView.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 26/3/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        Group {
            VStack {
                Image("mainFoto")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
