//
//  Result.swift
//  hemnet
//
//  Created by Christopher Lössl on 2018-06-16.
//  Copyright © 2018 Christopher Lössl. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

extension Result {
    /// Initializes a Result from an optional success value
    /// and an optional error. Useful for converting return
    /// values from many asynchronous Apple APIs to Result.
    init(value: T?, error: Error?) {
        switch (value, error) {
        case (let v?, _):
            // Ignore error if value is non-nil
            self = .success(v)
        case (nil, let e?):
            self = .failure(e)
        case (nil, nil):
            let error = NSError(domain: "ResultErrorDomain", code: 1,
                                userInfo: [NSLocalizedDescriptionKey:
                                    "Invalid input: value and error were both nil."])
            self = .failure(error)
        }
    }
}
