//
//  UIViewController+ErrorAlert.swift
//  Brejas
//
//  Created by Mateus Campos on 03/07/17.
//  Copyright © 2017 Mateus Campos. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showErrorAlert(withMessage message: String, tryAgain: @escaping () -> ()?) {
        
        let alertController: UIAlertController = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let tryAgainAction: UIAlertAction = UIAlertAction(title: "Tentar Novamente", style: .default) { (action) in
            tryAgain()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(tryAgainAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
