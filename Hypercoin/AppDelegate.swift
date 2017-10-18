//
//  AppDelegate.swift
//  Hypercoin
//
//  Created by Benjamin Prieur on 18/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)

	func applicationDidFinishLaunching(_ notification: Notification) {
		if let button = statusItem.button {
			button.image = NSImage(named: NSImage.Name("LogoBar"))
			button.action = #selector(printQuote(_:))
		}
	}

	@objc func printQuote(_ sender: Any?) {
		let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
		let quoteAuthor = "Mark Twain"

		print("\(quoteText) — \(quoteAuthor)")
	}
}
