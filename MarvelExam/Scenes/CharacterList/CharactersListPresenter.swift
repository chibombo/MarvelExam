//
//  CharactersListPresenter.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 22/03/21.
//

import Foundation

protocol CharactersListPresentationLogic {
    func presentCharactersList(response: FetchCharactersResponse)
    func presentAlert(error: Error)
}

class CharactersListPresenter: CharactersListPresentationLogic {

    weak var viewController: CharactersListDisplayLogic?

    init(viewController: CharactersListDisplayLogic) {
        self.viewController = viewController
    }

    init() {}

    func presentCharactersList(response: FetchCharactersResponse) {        viewController?.displayCharacters(characters: response.data.results)
    }
    func presentAlert(error: Error) {
        viewController?.displayAlert(title: "Error", message: error.localizedDescription)
    }
}
