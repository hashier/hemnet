//
//  Helper.swift
//  hemnet
//
//  Created by Christopher Lössl on 2018-06-16.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import UIKit.UIAlertController

extension UIAlertController {
    internal static func infoAlert(title: String?, message: String?, buttonTitle: String = "Okay", buttonAction: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in buttonAction?() })
        alert.addAction(okAction)

        return alert
    }
}
