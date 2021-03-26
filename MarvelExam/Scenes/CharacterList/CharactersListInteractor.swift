//
//  CharactersListInteractor.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 22/03/21.
//

import Foundation


protocol CharactersListBusinessLogic {
     func fetchCharacters()
}

class CharactersListInteractor: CharactersListBusinessLogic {

    var presenter: CharactersListPresentationLogic?
    var repository: MarvelRepositoryLogic?

    init(presenter: CharactersListPresentationLogic, repository: MarvelRepositoryLogic) {
        self.presenter = presenter
        self.repository = repository
    }

    init() {}

    func fetchCharacters() {
        repository?.fetchCharacters(completionHandler: { [weak self](result: Result<FetchCharactersResponse, NetworkingError>) in
            switch result {
            case .success(let response):
                self?.presenter?.presentCharactersList(response: response)
            case .failure(let error):
                self?.presenter?.presentAlert(error: error)
            }
        })
    }

}
