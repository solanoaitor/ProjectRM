//
//  CharacterMapper.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 28/3/25.
//

extension CharacterDTO {
    func toDomain() -> CharacterRM {
        CharacterRM(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin.name,
            location: location.name,
            image: image,
            episode: episode
        )
    }
}
