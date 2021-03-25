//
//  BaseViewController.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 24/03/21.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    var hud: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showHud(message: String = "Cargando") {
        let controller: UIViewController = navigationController ?? self
        hud = MBProgressHUD.showAdded(to: controller.view, animated: true)
        hud?.mode = MBProgressHUDMode.indeterminate
        hud?.label.text = message
    }
    
    func hideHud() {
        let controller: UIViewController = self.navigationController ?? self
        MBProgressHUD.hide(for: controller.view, animated: true)
    }
    
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
