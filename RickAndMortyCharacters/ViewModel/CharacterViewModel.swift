//
//  CharacterViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Diego Hernan Peñalba on 17/07/2023.
//

import Foundation

class CharacterViewModel: ObservableObject {
    
    @Published private(set) var state: State = .na
    
    private let service: CharacterService
    
    init(service: CharacterService) {
        self.service = service
    }
    
    func getCharacters() async {
        
        self.state = .loading
        
        do {
            let characters = try await service.fetchCharacters()
            self.state = .succes(data: characters)
        } catch {
            self.state = .failed(error: error)
        }
        
    }
    
    enum State {
        case na
        case loading
        case succes(data: [Character])
        case failed(error: Error)
    }
    
}
