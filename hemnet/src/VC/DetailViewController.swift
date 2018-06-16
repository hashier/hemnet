//
//  DetailViewController.swift
//  hemnet
//
//  Created by Christopher Lössl on 2018-06-16.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    // MARK: - IVar
    private var listing: Listing!

    // MARK: - IBOutlet
    @IBOutlet private weak var image: UIImageView! {
        didSet {
            image.sd_setImage(with: listing.thumbnail)
        }
    }
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var detail: UILabel!
    @IBOutlet private weak var price: UILabel!

    // MARK: - Init
    class func instantiateViewController(with listing: Listing) -> DetailViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController-StoryboardID") as! DetailViewController
        viewController.listing = listing

        return viewController
    }

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLabels()
    }

}

// MARK: - Methods
extension DetailViewController {
    fileprivate func setupLabels() {
        name.text = listing.streetAddress
        detail.text = "\(listing.municipality)\n\(listing.askingPrice)\n\(listing.livingSize) sqm\n\(listing.monthlyFee)\(listing.askingPrice)"
        price.text = listing.monthlyFee
    }
}

