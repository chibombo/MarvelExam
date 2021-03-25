//
//  FetchCharactersRepositoryMock.swift
//  MarvelExamDev
//
//  Created by Luis Genaro Arvizu Vega on 24/03/21.
//

import Foundation

class MarvelCharactersRepositoryMock: FetchCharactersLogic {
    func fetchCharacters(completionHandler: @escaping (Result<FetchCharactersResponse, NetworkingError>) -> Void) {
        if let data: Data = UtilitiesWorker.jsonToData(name: "FetchCharactersResponse") {
            do {
                let mock: FetchCharactersResponse = try JSONDecoder().decode(FetchCharactersResponse.self, from: data)
                completionHandler(.success(mock))
            } catch {
                completionHandler(.failure(.unknow))
            }
        }
    }

    func fetchCharacterDetail(request: CharacterDetailRequest, completionHandler: @escaping(Result<CharacterDetailResponse, NetworkingError>) -> Void) {
        if let data: Data = UtilitiesWorker.jsonToData(name: "CharacterDetailResponse") {
            do {
                let mock: CharacterDetailResponse = try JSONDecoder().decode(CharacterDetailResponse.self, from: data)
                completionHandler(.success(mock))
            } catch {
                completionHandler(.failure(.unknow))
            }
        }
    }
}
