//
//  ListMarketViewController.swift
//  Hypercoin
//
//  Created by Benjamin Prieur on 18/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import Cocoa

class ListMarketViewController: NSViewController {

	enum CellType {
		case title

		var columnIndex: Int {
			switch self {
			case .title:
				return 0
			default:
				return Int.max
			}
		}

		var cellIdentifier: String {
			switch self {
			case .title:
				return "CryptoTitleCell"
			default:
				return ""
			}
		}
	}

	// *********************************************************************
	// MARK: - Properties

	@IBOutlet fileprivate weak var tableView: NSTableView!

	// *********************************************************************
	// MARK: - LifeCycle

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = .clear
	}

	override func viewWillAppear() {
		super.viewWillAppear()
		// TODO: refresh data
	}

	// *********************************************************************
	// MARK: - Storyboard instantiation

	static func freshController() -> ListMarketViewController {
		let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
		let identifier = NSStoryboard.SceneIdentifier(rawValue: "ListCapViewController")
		guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ListMarketViewController else {
			fatalError("Why cant i find ListCapViewController? - Check Main.storyboard")
		}
		return viewcontroller
	}
}

// *********************************************************************
// MARK: - NSTableViewDataSource

extension ListMarketViewController: NSTableViewDataSource {

	func numberOfRows(in tableView: NSTableView) -> Int {
		return 5
	}
}

extension ListMarketViewController: NSTableViewDelegate {

	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

		var cellIdentifier: String = ""

		guard let tableColumn = tableColumn else {
			print("TableColumn must be available")
			return nil
		}

		switch tableColumn {
		case tableView.tableColumns[CellType.title.columnIndex]:
			cellIdentifier = CellType.title.cellIdentifier
		default:
			break
		}

		if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
			return cell
		}

		return nil
	}

	func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
		return 40
	}
}
