//
//  ListCapViewController.swift
//  Hypercoin
//
//  Created by Benjamin Prieur on 18/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import Cocoa

class ListCapViewController: NSViewController {

	// *********************************************************************
	// MARK: - Properties

	@IBOutlet fileprivate weak var tableView: NSTableView!

	// *********************************************************************
	// MARK: - LifeCycle

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
	}

	override func viewWillAppear() {
		super.viewWillAppear()
		// TODO: refresh data
	}

	// *********************************************************************
	// MARK: - Storyboard instantiation

	static func freshController() -> ListCapViewController {
		let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
		let identifier = NSStoryboard.SceneIdentifier(rawValue: "ListCapViewController")
		guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ListCapViewController else {
			fatalError("Why cant i find ListCapViewController? - Check Main.storyboard")
		}
		return viewcontroller
	}
}

// *********************************************************************
// MARK: - NSTableViewDataSource

extension ListCapViewController: NSTableViewDataSource {

	func numberOfRows(in tableView: NSTableView) -> Int {
		return 5
	}

	func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
		return 40
	}
}

extension ListCapViewController: NSTableViewDelegate {}
