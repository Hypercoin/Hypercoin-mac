//
//  ListMarketViewController.swift
//  Hypercoin
//
//  Created by Benjamin Prieur on 18/10/2017.
//  Copyright © 2017 Hypercoin. All rights reserved.
//

import Cocoa
import Marshal

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

	var market: [MarketCap] = []
	var coinNotifaction: [String: NotifiactionStatus] = [:]
	var refreshTimer: Timer?

	// *********************************************************************
	// MARK: - LifeCycle

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = .clear

		refreshTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(loadData), userInfo: nil, repeats: true)
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

	// *********************************************************************
	// MARK: - IBActions

	@IBAction func killApp(_ sender: AnyObject) {
		NSApplication.shared.terminate(self)
	}
}

// *********************************************************************
// MARK: - NSTableViewDataSource

extension ListMarketViewController: NSTableViewDataSource {

	func numberOfRows(in tableView: NSTableView) -> Int {
		return market.count
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
			cell?.textField?.stringValue = market[row].name
			return cell

		case tableView.tableColumns[CellType.value.columnIndex]:
			cellIdentifier = CellType.value.cellIdentifier
			let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView
			cell?.textField?.stringValue = "\(market[row].price[.usd]!)"
			return cell

		case tableView.tableColumns[CellType.percent.columnIndex]:
			cellIdentifier = CellType.percent.cellIdentifier
			let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? CryptoPercentCell
			if let percentChange = market[row].percentChange[.daily] {
				cell?.bgPercent.layer?.backgroundColor = percentChange < 0 ? NSColor.red.cgColor : NSColor.green.cgColor
				cell?.bgPercent.updateLayer()
				cell?.textField?.stringValue = "\(percentChange)%"
			}
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

private extension ListMarketViewController {

	@objc func loadData() {
		// TODO: refresh data
		let service = CoinMarketCapService()
		_ = service.getMarketCap().subscribe { event in
			//		_ = service.getStubMarketCap().subscribe { event in
			if let items = event.element {
				print("Reload data")
				self.market = items
				self.tableView.reloadData()
				self.notifyWhenBTCVariationAppear()
			} else if !event.isCompleted {
				print("somethings wrong happen with the service")
			}
		}
	}

	func notifyWhenBTCVariationAppear() {
		guard let btc = market.filter({ $0.name == "Bitcoin" }).first else {
			print("No bitcoin item in your list... How bitcoin could disappear... Another joke from Flipper the dolphin")
			return
		}

		guard let dailyPercentChange = btc.percentChange[.daily] else {
			return
		}

		let currentStatus = coinNotifaction["Bitcoin"] ?? .none
		if abs(dailyPercentChange) > 5, currentStatus == .none {
			let notification = NSUserNotification()
			notification.title = "BTC News"
			notification.informativeText = "BTC has \(dailyPercentChange)% change"
			notification.soundName = NSUserNotificationDefaultSoundName
			NSUserNotificationCenter.default.deliver(notification)
			coinNotifaction["Bitcoin"] = dailyPercentChange > 0 ? .up : .down
		} else if abs(dailyPercentChange) < 5, currentStatus != .none {
			let notification = NSUserNotification()
			notification.title = "BTC News"
			notification.informativeText = "BTC has \(dailyPercentChange)% change"
			notification.soundName = NSUserNotificationDefaultSoundName
			NSUserNotificationCenter.default.deliver(notification)
			coinNotifaction["Bitcoin"] = .none
		}
	}
}
