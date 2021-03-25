//
//  FetchCharactersRespository.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 24/03/21.
//

import Foundation

protocol MarvelRepositoryLogic: class {
    func fetchCharacters(completionHandler: @escaping(Result<FetchCharactersResponse, NetworkingError>) -> Void)
    func fetchCharacterDetail(request: CharacterDetailRequest, completionHandler: @escaping(Result<CharacterDetailResponse, NetworkingError>) -> Void)
}

class MarvelCharactersRepository: BaseRepository, MarvelRepositoryLogic {

    func fetchCharacters(completionHandler: @escaping (Result<FetchCharactersResponse, NetworkingError>) -> Void) {
        let timestamp = Int(Date().timeIntervalSinceReferenceDate)
        let hash = ("\(timestamp)"+privateKey+publicKey).MD5
        let endpoint = "https://gateway.marvel.com:443/v1/public/characters?limit=50&ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)"
        urlSession.executeRequest(url: endpoint,
                                  httpMethod: .get,
                                  headers: nil,
                                  timeout: 10,
                                  responseType: FetchCharactersResponse.self) { (result: Result<FetchCharactersResponse, NetworkingError>) in
            switch result {
            case .success(let response): completionHandler(.success(response))
            case .failure(let error): completionHandler(.failure(error))
            }
        }
    }

    func fetchCharacterDetail(request: CharacterDetailRequest, completionHandler: @escaping(Result<CharacterDetailResponse, NetworkingError>) -> Void) {
        let timestamp = Int(Date().timeIntervalSinceReferenceDate)
        let hash = ("\(timestamp)"+privateKey+publicKey).MD5
        let endpoint = "https://gateway.marvel.com:443/v1/public/characters/\(request.id)?ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)"
        urlSession.executeRequest(url: endpoint,
                                  httpMethod: .get,
                                  headers: nil,
                                  timeout: 10,
                                  responseType: CharacterDetailResponse.self) { (result: Result<CharacterDetailResponse, NetworkingError>) in
            switch result {
            case .success(let response): completionHandler(.success(response))
            case .failure(let error): completionHandler(.failure(error))
            }
        }
    }
}
