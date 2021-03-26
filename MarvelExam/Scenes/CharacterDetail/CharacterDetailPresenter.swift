//
//  CharacterDetailPresenter.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 24/03/21.
//

import Foundation

protocol CharacterDetailPresentationLogic: class {
    func presentDetail(response: CharacterDetailResponse)
    func presentAlert(error: Error)
}

class CharacterDetailPresenter: CharacterDetailPresentationLogic {
    
    weak var viewController: CharacterDetailDisplayLogic?
    
    init() {}
    
    init(viewController: CharacterDetailDisplayLogic?) {
        self.viewController = viewController
    }
    
    func presentDetail(response: CharacterDetailResponse) {
        if let details: Character = response.data.results.first {
            viewController?.displayDetail(detail: details)
        } else {
            viewController?.displayAlert(title: "Error", message: NetworkingError.unknow.localizedDescription)
        }
        
    }
    func presentAlert(error: Error) {
        viewController?.displayAlert(title: "Error", message: error.localizedDescription)
    }
}
