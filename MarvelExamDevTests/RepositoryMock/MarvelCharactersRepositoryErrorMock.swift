//
//  MarvelCharactersRepositoryErrorMock.swift
//  MarvelExamDevTests
//
//  Created by Luis Genaro Arvizu Vega on 26/03/21.
//

import Foundation
@testable import MarvelExamDev

class MarvelCharactersRepositoryErrorMock: MarvelRepositoryLogic {
    func fetchCharacters(completionHandler: @escaping (Result<FetchCharactersResponse, NetworkingError>) -> Void) {
        completionHandler(.failure(NetworkingError.serviceError))
    }
    
    func fetchCharacterDetail(request: CharacterDetailRequest, completionHandler: @escaping (Result<CharacterDetailResponse, NetworkingError>) -> Void) {
        completionHandler(.failure(NetworkingError.serviceError))
    }
    
    
}
