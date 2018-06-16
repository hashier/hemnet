//
//  hemnetTests.swift
//  hemnetTests
//
//  Created by Christopher Lössl on 2018-06-16.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import XCTest
@testable import hemnet

class hemnetTests: XCTestCase {

    func testJSONDecode() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let decoder = JSONDecoder()
        do {
            let container = try decoder.decode(Listings.self, from: validJsonData)

            XCTAssertEqual(container.listings.count, 2)

            let test1 = container.listings.first!
            XCTAssertEqual(test1.listingType, .active)
            XCTAssertEqual(test1.id, "1234567890")
            XCTAssertEqual(test1.askingPrice, "2 650 000 kr")
            XCTAssertEqual(test1.monthlyFee, "1 498 kr/mån")
            XCTAssertEqual(test1.municipality, "Gällivare kommun")
            XCTAssertEqual(test1.location, "Heden")
            XCTAssertEqual(test1.daysOnHemnet, 1)
            XCTAssertEqual(test1.livingSize, 120)
            XCTAssertEqual(test1.numberOfRooms, 5)
            XCTAssertEqual(test1.streetAddress, "Mockvägen 1") // haha!
            XCTAssertEqual(test1.thumbnail, URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg"))

            let test2 = container.listings.last!
            XCTAssertEqual(test2.listingType, .deactivated)
        } catch {
            XCTFail("JSON decoding failed: \(error)")
        }
    }

}

private let validJsonData = validJson.data(using: .utf8)!
private let validJson = """
{
"listings": [{
"listingType": "ActivePropertyListing",
"id": "1234567890",
"askingPrice": "2 650 000 kr",
"monthlyFee": "1 498 kr/mån",
"municipality": "Gällivare kommun",
"area": "Heden",
"daysOnHemnet": 1,
"livingArea": 120,
"numberOfRooms": 5,
"streetAddress": "Mockvägen 1",
"thumbnail": "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hus_i_svarttorp.jpg/800px-Hus_i_svarttorp.jpg"
},
{
"listingType": "DeactivatedPropertyListing",
"id": "1234567892",
"askingPrice": "3 150 000 kr",
"monthlyFee": "2 298 kr/mån",
"municipality": "Östersunds kommun",
"area": "Frösön",
"daysOnHemnet": 12,
"livingArea": 79,
"numberOfRooms": 5,
"streetAddress": "Mockvägen 3",
"thumbnail": "https://commons.wikimedia.org/wiki/File:Tryckeribolagets_hus_Sundsvall_17.JPG"
}]}
"""
