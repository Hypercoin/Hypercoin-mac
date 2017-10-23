//
//  MarshaledObject.swift
//  Hypercoin
//
//  Created by Axel Etcheverry on 23/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import Foundation
import Marshal

extension MarshaledObject {
    func value<T>(for key: String, defaultValue: T) throws -> T {
        let value = try? any(for: key)
        switch value {
        case .some(let tmp as String):
            if let result = tmp as? T {
                return result
            } else {
                return defaultValue
            }
        case .some(let tmp as T):
            return tmp
        default:
            return defaultValue
        }
    }

    func double(for key: String, defaultValue: Double) throws -> Double {
        let value = try? any(for: key)
        switch value {
        case .some(let tmp as String):
            if let result = Double(tmp) {
                return result
            } else {
                return defaultValue
            }
        case .some(let tmp as Double):
            return tmp
        default:
            return defaultValue
        }
    }
}
