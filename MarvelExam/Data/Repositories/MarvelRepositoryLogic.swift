//
//  MarvelRepositoryLogic.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 25/03/21.
//

import Foundation

protocol MarvelRepositoryLogic: class {
    func fetchCharacters(completionHandler: @escaping(Result<FetchCharactersResponse, NetworkingError>) -> Void)
    func fetchCharacterDetail(request: CharacterDetailRequest, completionHandler: @escaping(Result<CharacterDetailResponse, NetworkingError>) -> Void)
}
