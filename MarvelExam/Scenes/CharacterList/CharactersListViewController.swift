//
//  CharactersListViewController.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 22/03/21.
//

import UIKit

protocol CharactersListDisplayLogic: class {
    func displayCharacters(characters: [Character])
    func displayAlert(title: String, message: String)
}

class CharactersListViewController: BaseViewController {
    // MARK: - Outlets

    lazy var tableView: UITableView = {
        let table: UITableView = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()

    // MARK: - Variables
    var interactor: CharactersListBusinessLogic?
    var router: CharactersListRouter?

    var characters: [Character] = []

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
        showHud()
        interactor?.fetchCharacters()
    }

    private func setupUI() {
        view.addSubview(tableView)
        setupConstraints()
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        let constraints: [NSLayoutConstraint] = [tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
                                                 tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
                                                 tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0),
                                                 tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0)]
        NSLayoutConstraint.activate(constraints)
    }

    private func setup() {
        let viewController = self
        let interactor = CharactersListInteractor()
        let presenter = CharactersListPresenter()
        let router = CharactersListRouter()
        #if PRODUCTION
        interactor.repository = MarvelCharactersRepository()
        #elseif DEV
        interactor.repository = MarvelCharactersRepositoryMock()
        #endif
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.navigationController = viewController.navigationController
    }
}
// MARK: - CharactersListDisplayLogic Methods
extension CharactersListViewController: CharactersListDisplayLogic {

    func displayCharacters(characters: [Character]) {
        DispatchQueue.main.async {
            self.characters = characters
            self.tableView.reloadData()
            self.hideHud()
        }

    }

    func displayAlert(title: String, message: String) {
        DispatchQueue.main.async {
            self.hideHud()
            self.showAlert(title: title, message: message, buttonText: "Reintentar") { [weak self](_) in
                self?.showHud()
                self?.interactor?.fetchCharacters()
            }
        }

    }
}
// MARK: - UITableView Methods
extension CharactersListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.text = characters[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        router?.routeToDetail(id: character.id)
    }
}
