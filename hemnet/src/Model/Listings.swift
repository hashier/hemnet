//
//  Listings.swift
//  hemnet
//
//  Created by Christopher Lössl on 2018-06-16.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import Foundation

enum listingType {
    case active
    case deactivated
    case other
}

// MARK: - Listings
internal struct Listings: Decodable {
    internal let listings: [Listing]
}

// MARK: - Listing
internal struct Listing: Decodable {
    internal let listingType: listingType
    internal let id: String
    internal let askingPrice: String
    internal let monthlyFee: String
    internal let municipality: String
    internal let location: String
    internal let daysOnHemnet: Int
    internal let livingSize: Int
    internal let numberOfRooms: Int
    internal let streetAddress: String
    internal let thumbnail: URL

    private enum CodingKeys: String, CodingKey {
        case listingType
        case id
        case askingPrice
        case monthlyFee
        case municipality
        case location = "area"
        case daysOnHemnet
        case livingSize = "livingArea"
        case numberOfRooms
        case streetAddress
        case thumbnail
    }
}

extension Listing {
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)

        let listingTypeString = try rootContainer.decode(String.self, forKey: .listingType)
        if listingTypeString == "ActivePropertyListing" {
            listingType = .active
        } else if listingTypeString == "DeactivatedPropertyListing" {
            listingType = .deactivated
        } else {
            listingType = .other
        }
        id = try rootContainer.decode(String.self, forKey: .id)
        askingPrice = try rootContainer.decode(String.self, forKey: .askingPrice)
        monthlyFee = try rootContainer.decode(String.self, forKey: .monthlyFee)
        municipality = try rootContainer.decode(String.self, forKey: .municipality)
        location = try rootContainer.decode(String.self, forKey: .location)
        daysOnHemnet = try rootContainer.decode(Int.self, forKey: .daysOnHemnet)
        livingSize = try rootContainer.decode(Int.self, forKey: .livingSize)
        numberOfRooms = try rootContainer.decode(Int.self, forKey: .numberOfRooms)
        streetAddress = try rootContainer.decode(String.self, forKey: .streetAddress)
        thumbnail = try rootContainer.decode(URL.self, forKey: .thumbnail)
    }
}
