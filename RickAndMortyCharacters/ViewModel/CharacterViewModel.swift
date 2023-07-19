//
//  CharacterViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Diego Hernan Peñalba on 17/07/2023.
//

import Foundation

@MainActor
class CharacterViewModel: ObservableObject {
    
    @Published private(set) var state: State = .na
    @Published var hasError: Bool = false
    
    private let service: CharacterService
    
    init(service: CharacterService) {
        self.service = service
    }
    
    func getCharacters() async {
        
        self.state = .loading
        self.hasError = false
        
        do {
            let characters = try await service.fetchCharacters()
            self.state = .succes(data: characters)
        } catch {
            self.state = .failed(error: error)
            self.hasError = true
        }
        
    }
    
    enum State {
        case na
        case loading
        case succes(data: [Character])
        case failed(error: Error)
    }
    
}
