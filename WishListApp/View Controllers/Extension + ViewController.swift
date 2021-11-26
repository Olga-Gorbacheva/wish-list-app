//
//  Extension + ViewController.swift
//  WishListApp
//
//  Created by Ольга Горбачева on 21.11.21.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String) {
         let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
         alertVC.addAction(alertAction)
         present(alertVC, animated: true)
     }
}
