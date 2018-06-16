//
//  ListingsTableViewController.swift
//  hemnet
//
//  Created by Christopher Lössl on 2018-06-16.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import UIKit

class ListingsTableViewController: UITableViewController {

    // MARK: - IVar
    var currentDesign: Design = .old
    var listings: [Listing]? {
        didSet {
            DispatchQueue.main.async {
                self.updateTitle()
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        updateTitle()
        tableView.tableFooterView = UIView(frame: .zero)

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Toggle layout",
            style: .plain,
            target: self,
            action: #selector(didTapToggle(_:)))

        let listingTableViewCellNib = UINib(nibName: "ListingTableViewCell", bundle: nil)
        tableView.register(listingTableViewCellNib, forCellReuseIdentifier: ListingTableViewCell.listingTableViewCellIdent)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        getListings()
    }
}

// MARK: - Private Methods
internal extension ListingsTableViewController {
    private func getListings() {
        RESTClient().getListings { resultContainer in
            switch resultContainer {
            case let .success(container):
                self.listings = container.listings
            case let .failure(error):
                let alert = UIAlertController.infoAlert(title: "Error", message: error.localizedDescription)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    private func updateTitle() {
        var string = "Listings"
        if let listings = listings {
            string = "\(listings.count) listings"
        }
        DispatchQueue.main.async {
            self.title = string
        }
    }

    private func toggleDesign() {
        if currentDesign == .new {
            currentDesign = .old
        } else {
            currentDesign = .new
        }

        let set = IndexSet(integer: 0)
        tableView.beginUpdates()
        tableView.reloadSections(set, with: .automatic)
        tableView.endUpdates()
    }
}

// MARK: - Objc / Selector methods
internal extension ListingsTableViewController {
    @objc private func didTapToggle(_ sender: UIBarButtonItem) {
        toggleDesign()
    }
}

// MARK: - Table view data source
internal extension ListingsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListingTableViewCell.listingTableViewCellIdent, for: indexPath) as! ListingTableViewCell

        cell.design = currentDesign
        cell.listing = listings?[indexPath.row]

        return cell
    }

}

// MARK: - Table view delegate
internal extension ListingsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let viewController = DetailViewController.instantiateViewController(with: (listings?[indexPath.row])!)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
