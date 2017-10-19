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
		case value
		case percent

		var columnIndex: Int {
			switch self {
			case .title:
				return 0
			case .value:
				return 1
			case .percent:
				return 2
			}
		}

		var cellIdentifier: String {
			switch self {
			case .title:
				return "CryptoTitleCell"
			case .value:
				return "CryptoValueCell"
			case .percent:
				return "CryptoPercentCell"
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
			let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView
			cell?.textField?.stringValue = "Demo"
			return cell

		case tableView.tableColumns[CellType.value.columnIndex]:
			cellIdentifier = CellType.value.cellIdentifier
			let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView
			cell?.textField?.stringValue = "Coucou"
			return cell

		case tableView.tableColumns[CellType.percent.columnIndex]:
			cellIdentifier = CellType.percent.cellIdentifier
			let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? CryptoPercentCell
			cell?.textField?.stringValue = "0.00%"
			return cell

		default:
			break
		}

		return nil
	}

	func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
		return 40
	}
}
