//
//  ViewController.swift
//  hemnet
//
//  Created by Christopher Lössl on 2018-06-16.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        RESTClient().getListings { resultContainer in
            switch resultContainer {
            case let .success(container):
                print(container.listings)
            case let .failure(error):
                let alert = UIAlertController.infoAlert(title: "Error", message: error.localizedDescription)
                DispatchQueue.main.async {
                    self.navigationController?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

}

