//
//  ProjectRMUnitTests.swift
//  ProjectRMUnitTests
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

import XCTest
@testable import ProjectRM

final class CharacterViewModelTests: XCTestCase {
    
    class MockGetCharactersUseCase: GetCharactersUseCase {
        func execute() async throws -> [CharacterRM] {
            return [
                CharacterRM(id: 1, name: "Rick", status: "Alive", species: "Human", type: "", gender: "Male", origin: "Earth", location: "Earth", image: "", episode: [], created: "")
            ]
        }
    }

    func testLoadCharactersSuccess() async {
        let viewModel = await CharacterViewModel(getCharactersUseCase: MockGetCharactersUseCase())

        await viewModel.loadCharacters()

        await MainActor.run {
            XCTAssertEqual(viewModel.characters.count, 1)
            XCTAssertEqual(viewModel.characters.first?.name, "Rick")
        }
    }
}
