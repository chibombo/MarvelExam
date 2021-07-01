//
//  CharacterDetailViewController.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 24/03/21.
//

import UIKit
import Kingfisher
import SkeletonView

protocol CharacterDetailDisplayLogic: AnyObject {
    func displayDetail(detail: Character)
    func displayAlert(title: String, message: String)
}

class CharacterDetailViewController: BaseViewController {
// MARK: - Outlets
    lazy var avatarImage: UIImageView = {
        let view: UIImageView = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 55
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view: UILabel = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.textColor = UIColor.darkClouds
        view.minimumScaleFactor = 0.5
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view: UILabel = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        view.numberOfLines = 5
        view.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        view.adjustsFontSizeToFitWidth = true
        view.sizeToFit()
        view.textAlignment = .left
        view.textColor = UIColor.darkClouds
        view.minimumScaleFactor = 0.5
        return view
    }()
    
    // MARK: - Variables
    var interactor: CharacterDetailBusinessLogic?
    
    var characterId: Int = 0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupUI()
        let request = CharacterDetailRequest(id: characterId)
        interactor?.getCharacterDetail(request: request)
    }
    
    private func setupUI() {
        view.addSubview(avatarImage)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.backgroundColor = UIColor(named: "Yellow")
        setupConstraints()
        view.isSkeletonable = true
        avatarImage.skeletonCornerRadius = 55
        avatarImage.showAnimatedGradientSkeleton()
        nameLabel.showAnimatedGradientSkeleton()
        descriptionLabel.showAnimatedGradientSkeleton()
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        let imageConstraints = [avatarImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
                                avatarImage.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
                                avatarImage.widthAnchor.constraint(equalToConstant: 110),
                                avatarImage.heightAnchor.constraint(equalToConstant: 110)]
        
        NSLayoutConstraint.activate(imageConstraints)
        
        let nameConstraints = [nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15),
                               nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
                               nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
                               nameLabel.heightAnchor.constraint(equalToConstant: 30)]
        
        NSLayoutConstraint.activate(nameConstraints)
        
        let descriptionConstraints = [descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
                                      descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
                                      descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -16),
                                      descriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)]
        
        NSLayoutConstraint.activate(descriptionConstraints)
    }
    
    private func toggleSkeleton() {
        if nameLabel.isSkeletonActive {
            nameLabel.hideSkeleton()
            descriptionLabel.hideSkeleton()
        } else {
            avatarImage.showAnimatedGradientSkeleton()
            nameLabel.showAnimatedGradientSkeleton()
            descriptionLabel.showAnimatedGradientSkeleton()
        }
    }
    
    private func setup() {
        let viewController = self
        let interactor = CharacterDetailInteractor()
        let presenter = CharacterDetailPresenter()
        #if PRODUCTION
        interactor.repository = MarvelCharactersRepository()
        #elseif DEV
        interactor.repository = MarvelCharactersRepositoryMock()
        #endif
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    
    
}

// MARK: - CharacterDetailDisplayLogic Methods
extension CharacterDetailViewController: CharacterDetailDisplayLogic {
   
    func displayDetail(detail: Character) {
        let urlString = "\(detail.thumbnail.path).\(detail.thumbnail.fileType)"
        
        DispatchQueue.main.async {
            self.descriptionLabel.numberOfLines = 0
            self.nameLabel.text = detail.name
            self.descriptionLabel.text = detail.description.isEmpty ? "Este personaje no cuenta con descripción." : detail.description
            
            self.avatarImage.kf.setImage(with: URL(string: urlString), placeholder: nil, options: nil) { [weak self](result: Result<RetrieveImageResult, KingfisherError>) in
                switch result {
                case .success:
                    self?.avatarImage.layer.cornerRadius = 55
                    self?.avatarImage.hideSkeleton()
                case .failure(let error):
                    self?.displayAlert(title: "Error", message: error.localizedDescription)
                }
            }
            self.toggleSkeleton()
        }
    }
    
    func displayAlert(title: String, message: String) {
        showAlert(title: title, message: message, buttonText: "Regresar") { [weak self](_) in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
