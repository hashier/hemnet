//
//  RESTClient.swift
//  hemnet
//
//  Created by Christopher Lössl on 2018-06-16.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import Foundation

internal class RESTClient {

    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return URLSession(configuration: config)
    }()

    internal func getListings(_ completion: @escaping (Result<Listings>) -> Void) {
        let task = session.dataTask(with: URL(string: Constants.url)!) { (responseData, response, error) in
            let requestResult = Result(value: responseData, error: error)
            switch requestResult {
            case .success(let data):
                let decodeResult = RESTClient.decode(Listings.self, from: data)
                completion(decodeResult)
            case .failure(let msg):
                let error = NSError(domain: "Network", code: 1,
                                    userInfo: [NSLocalizedDescriptionKey: "Network: \(msg)"])
                completion(.failure(error))
            }
        }
        task.resume()
    }

}

private extension RESTClient {
    private static let jsonDecoder = JSONDecoder()

    private static func decode<T: Decodable>(_ type: T.Type, from data: Data) -> Result<T> {
        do {
            let responseObject = try jsonDecoder.decode(T.self, from: data)
            return .success(responseObject)
        } catch let parseError {
            print("Error: \(parseError)")
            let error = NSError(domain: "Decode", code: 1,
                                userInfo: [NSLocalizedDescriptionKey: "Decode: \(parseError)"])
            return .failure(error)
        }
    }
}
