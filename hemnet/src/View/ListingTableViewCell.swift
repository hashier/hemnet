//
//  ListingTableViewCell.swift
//  hemnet
//
//  Created by Christopher Lössl on 2018-06-16.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import UIKit
import SDWebImage

class ListingTableViewCell: UITableViewCell {

    // MARK: - Static
    static let listingTableViewCellIdent = "listingTableViewCellIdent"

    // MARK: - IBOutlet
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var rooms: UILabel!
    @IBOutlet weak var monthlyCost: UILabel!
    @IBOutlet weak var onlineSince: UILabel!

    // MARK: - IVar
    internal var listing: Listing? {
        didSet {
            guard let listing = listing else { return }

            let url = listing.thumbnail
            titleImage?.sd_setImage(with: url, completed: { (_, _, _, _) in
                self.setNeedsLayout()
            })

            title.text = listing.streetAddress
            location.text = listing.location
            price.text = listing.askingPrice
            size.text = "\(String(listing.livingSize)) m²"
            rooms.text = "\(String(listing.numberOfRooms)) rum"
            monthlyCost.text = listing.monthlyFee
            // Don't do this in production code!
            let days: String
            if listing.daysOnHemnet == 1 {
                days = "dag"
            } else {
                days = "dagar"
            }
            onlineSince.text = "\(String(listing.daysOnHemnet)) \(days)"
        }
    }

    // MARK: - View
    override func prepareForReuse() {
        super.prepareForReuse()

        imageView?.sd_cancelCurrentImageLoad()
    }

}
