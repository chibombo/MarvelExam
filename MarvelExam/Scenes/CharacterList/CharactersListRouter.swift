//
//  CharactersListRouter.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 22/03/21.
//

import UIKit

protocol CharactersListRoutingLogic: class {
    var navigationController: UINavigationController? {get}

    func routeToDetail(id: Int)

}

class CharactersListRouter: CharactersListRoutingLogic {

    weak var navigationController: UINavigationController?

    func routeToDetail(id: Int) {
        let controller = CharacterDetailViewController()
        controller.characterId = id
        navigationController?.pushViewController(controller, animated: true)
    }

}
