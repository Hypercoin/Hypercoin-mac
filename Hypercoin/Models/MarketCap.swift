//
//  MarketCapService.swift
//  Hypercoin
//
//  Created by Axel Etcheverry on 18/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import Foundation
import Marshal

extension MarshaledObject {
	func value<T>(for key: String, defaultValue: T) throws -> T {
		let value = try? any(for: key)
		switch value {
		case .some(let tmp as String):
			if let result =  tmp as? T {
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
}

struct MarketCap: Unmarshaling {
	public var id: String
	public var name: String
	public var symbol: String
	public var rank: Int
	public var price: [String: Double]
	public var volumeUsd24h: Double
	public var marketCapUsd: Double
	public var availableSupply: Double
	public var totalSupply: Double
	public var percentChange: [String: Double]
	public var lastUpdated: Int64

	init(object: MarshaledObject) throws {
		self.price = [:]
		self.percentChange = [:]

		self.id = try object.value(for: "id")
		self.name = try object.value(for: "name")
		self.symbol = try object.value(for: "symbol")
		self.rank = try object.value(for: "rank", defaultValue: 0)
		self.price["usd"] = try object.value(for: "price_usd", defaultValue: 0)
		self.price["btc"] = try object.value(for: "price_btc", defaultValue: 0)
		self.volumeUsd24h = try object.value(for: "24h_volume_usd", defaultValue: 0)
		self.marketCapUsd = try object.value(for: "market_cap_usd", defaultValue: 0)
		self.availableSupply = try object.value(for: "available_supply", defaultValue: 0)
		self.totalSupply = try object.value(for: "total_supply", defaultValue: 0)
		self.percentChange["1h"] = try object.value(for: "percent_change_1h", defaultValue: 0)
		self.percentChange["24h"] = try object.value(for: "percent_change_24h", defaultValue: 0)
		self.percentChange["7d"] = try object.value(for: "percent_change_7d", defaultValue: 0)
		self.lastUpdated = try object.value(for: "last_updated", defaultValue: 0)
	}
}


