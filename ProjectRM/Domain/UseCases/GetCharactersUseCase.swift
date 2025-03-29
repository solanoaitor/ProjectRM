//
//  GetCharactersUseCase.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

import Foundation

protocol GetCharactersUseCase {
    func execute() async throws -> [CharacterRM]
}
