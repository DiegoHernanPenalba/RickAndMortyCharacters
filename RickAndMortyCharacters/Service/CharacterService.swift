//
//  CharacterService.swift
//  RickAndMortyCharacters
//
//  Created by Diego Hernan Peñalba on 14/07/2023.
//

import Foundation

struct CharacterService {
    
    func fetchCharacters() async throws -> [Character] {
        
        let url = URL(string:  "https:rickandmortyapi.com/api/character")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
                throw CharacterServiceError.invalidStatusCode
        }
        
        let decodedData = try JSONDecoder().decode(CharacterServiceResult.self, from: data)
        
        return decodedData.result
    }
    
    enum CharacterServiceError: Error {
        case failed
        case failedToDecode
        case invalidStatusCode
    }
}
