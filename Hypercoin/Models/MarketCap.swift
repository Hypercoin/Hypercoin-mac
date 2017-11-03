//
//  MarketCapService.swift
//  Hypercoin
//
//  Created by Axel Etcheverry on 18/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import Foundation
import Marshal

struct MarketCap: Unmarshaling {
	public var id: String
	public var name: String
	public var symbol: String
	public var rank: Int
	public var price: [CurrencyType: Double]
	public var volume24h: [CurrencyType: Double]
	public var marketCap: [CurrencyType: Double]
	public var availableSupply: Double
	public var totalSupply: Double
	public var percentChange: [ChangePeriodType: Double]
	public var lastUpdated: Int64

	init(object: MarshaledObject) throws {
		self.price = [:]
		self.percentChange = [:]
		self.volume24h = [:]
		self.marketCap = [:]

		self.id = try object.value(for: "id")
		self.name = try object.value(for: "name")
		self.symbol = try object.value(for: "symbol")
		self.rank = try object.value(for: "rank", defaultValue: 0)
		self.availableSupply = try object.double(for: "available_supply", defaultValue: 0)
		self.totalSupply = try object.double(for: "total_supply", defaultValue: 0)
		self.lastUpdated = try object.value(for: "last_updated", defaultValue: 0)

		for currency in CurrencyType.allValues {
			if let price = try? object.double(for: "price_\(currency)", defaultValue: 0), price > 0 {
				self.price[currency] = price
			}

			if let price = try? object.double(for: "24h_volume_\(currency)", defaultValue: 0), price > 0 {
				self.volume24h[currency] = price
			}

			if let price = try? object.double(for: "market_cap_\(currency)", defaultValue: 0), price > 0 {
				self.marketCap[currency] = price
			}
		}


		self.percentChange[.hourly] = try object.double(for: "percent_change_1h", defaultValue: 0)
		self.percentChange[.daily] = try object.double(for: "percent_change_24h", defaultValue: 0)
		self.percentChange[.weekly] = try object.double(for: "percent_change_7d", defaultValue: 0)
	}
}


