//
//  EventMonitorManager.swift
//  Hypercoin
//
//  Created by Benjamin Prieur on 18/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import Cocoa

class EventMonitorManager {

	// *********************************************************************
	// MARK: - Properties

	private var monitor: Any?
	private let mask: NSEvent.EventTypeMask
	private let handler: (NSEvent?) -> Void

	// *********************************************************************
	// MARK: - LifeCycle

	init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> Void) {
		self.mask = mask
		self.handler = handler
	}

	deinit {
		stop()
	}

	// *********************************************************************
	// MARK: - Public Methods

	func start() {
		monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
	}

	func stop() {
		if let monitor = self.monitor {
			NSEvent.removeMonitor(monitor)
			self.monitor = nil
		}
	}
}
