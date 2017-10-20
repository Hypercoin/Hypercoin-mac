//
//  JsonHelper.swift
//  Hypercoin
//
//  Created by Benjamin Prieur on 20/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import Foundation

class JsonHelper {
	static func readJsonFile(fileName: String) -> Data {
		var jsonData = Data()
		if let path = Bundle(for: JsonHelper.self).path(forResource: fileName, ofType: "json"),
			let json = NSData(contentsOfFile: path) as Data? {
			jsonData = json
		}
		return jsonData
	}
}
