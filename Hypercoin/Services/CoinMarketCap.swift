//
//  CoinMarketCap.swift
//  Hypercoin
//
//  Created by Axel Etcheverry on 18/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire
import Marshal

class CoinMarketCap {
	fileprivate var url = "https://api.coinmarketcap.com/v1/ticker/"

	init() {

	}

	public func getMarketCap() -> Observable<[MarketCap]> {
		return RxAlamofire.request(.get, self.url)
			.debug()
			.flatMap { request in
				return Observable.create { observer in
					_ = request.validate(statusCode: 200..<300)
						.validate(contentType: ["application/json"])
						.rx.data().subscribe { data in
							do {
								guard let jsonData = data.element else {
									// @TODO: Create custom error
									observer.on(.completed)
									return
								}

								let json = try JSONParser.JSONArrayWithData(jsonData)

								let coins = json.flatMap { item in
									return try? MarketCap(object: item)
								}

								observer.on(.next(coins))
								observer.on(.completed)
							} catch let error {
								observer.on(.error(error))
							}
					}

					return Disposables.create()
				}
		}
	}
}
