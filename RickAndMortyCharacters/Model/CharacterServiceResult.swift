//
//  CharacterServiceResult.swift
//  RickAndMortyCharacters
//
//  Created by Diego Hernan Peñalba on 14/07/2023.
//

import Foundation

struct CharacterServiceResult: Codable {
    let results : [Character]
    
}

struct Character: Codable {
    let id: Int
    let name: String
    let image: String
}
