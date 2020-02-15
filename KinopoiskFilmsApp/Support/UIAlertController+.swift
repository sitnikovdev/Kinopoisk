//
//  UIAlertController+.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 14.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    static func alert(title: String, message: String, isCancelable: Bool = false) -> UIAlertController {
        let alertController  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        if isCancelable {
            alertController.addAction(cancelAction)
        }
        alertController.addAction(okAction)
        
        return alertController
    }
}
