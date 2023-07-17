//
//  ContentView.swift
//  RickAndMortyCharacters
//
//  Created by Diego Hernan Peñalba on 14/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = CharacterViewModel(service: CharacterService())
    
    var body: some View {
        NavigationView {
            
            switch viewModel.state {
                
            case .succes(let data):
                List {
                    ForEach(data, id: \.id) { character in
                        Text(character.name)
                    }
                    
                    .navigationTitle("Characters")
                }
                
            case .loading:
                ProgressView()
                
            default:
                EmptyView()
            }
        }
        .task {
            await viewModel.getCharacters()
        }
        .alert("Error",
               isPresented: $viewModel.hasError,
               presenting: viewModel.state) { detail in
            
            Button("Retry") {
                Task {
                    await viewModel.getCharacters()
                }
            }
        } message: { detail in
            if case let .failed(error) = detail {
                Text(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
