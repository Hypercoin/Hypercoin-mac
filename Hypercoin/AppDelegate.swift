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

	// *********************************************************************
	// MARK: - Properties

	let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
	let popover = NSPopover()
	var eventMonitor: EventMonitorManager?

	// *********************************************************************
	// MARK: - LifeCycle

	func applicationDidFinishLaunching(_ notification: Notification) {
		setupStatusItem()
		setupEventMonitor()
		popover.contentViewController = ListMarketViewController.freshController()
		popover.contentSize = CGSize(width: 300, height: 300)
	}

	// *********************************************************************
	// MARK: - Public Methods

	@objc func togglePopover(_ sender: Any?) {
		if popover.isShown {
			closePopover(sender: sender)
		} else {
			showPopover(sender: sender)
		}
	}

	// *********************************************************************
	// MARK: - Private Methods

	private func setupStatusItem() {
		if let button = statusItem.button {
			button.image = NSImage(named: NSImage.Name("LogoBar"))
			button.action = #selector(togglePopover(_:))
		}
	}

	private func setupEventMonitor() {
		eventMonitor = EventMonitorManager(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
			if let strongSelf = self, strongSelf.popover.isShown {
				strongSelf.closePopover(sender: event)
			}
		}
	}

	private func showPopover(sender: Any?) {
		if let button = statusItem.button {
			popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
		}
		eventMonitor?.start()
	}

	private func closePopover(sender: Any?) {
		popover.performClose(sender)
		eventMonitor?.stop()
	}
}
