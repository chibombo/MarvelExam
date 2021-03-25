//
//  CharacterDetailInteractor.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 24/03/21.
//

import Foundation

protocol CharacterDetailBusinessLogic: class {
    func getCharacterDetail(request: CharacterDetailRequest)
}

class CharacterDetailInteractor: CharacterDetailBusinessLogic {
    
    var presenter: CharacterDetailPresentationLogic?
    var repository: MarvelRepositoryLogic?
    
    func getCharacterDetail(request: CharacterDetailRequest) {
        repository?.fetchCharacterDetail(request: request, completionHandler: { [weak self](result: Result<CharacterDetailResponse, NetworkingError>) in
            switch result {
            case .success(let response): self?.presenter?.presentDetail(response: response)
            case .failure(let error): self?.presenter?.presentAlert(error: error)
            }
        })
    }
}
