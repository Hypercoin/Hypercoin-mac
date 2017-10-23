//
//  ChangePeriod.swift
//  Hypercoin
//
//  Created by Axel Etcheverry on 23/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import Foundation


public enum ChangePeriodType: String {
    case hourly
    case daily
    case weekly

    static let allValues = [
        hourly, daily, weekly
    ]
}
