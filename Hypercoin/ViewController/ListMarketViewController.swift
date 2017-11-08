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
	@IBOutlet fileprivate weak var loader: NSProgressIndicator!

	let service = CoinMarketCapService()
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
		loader.startAnimation(self)

		_ = service.getMarketCap().subscribe { [weak self] event in
//		_ = service.getStubMarketCap().subscribe { event in

			guard let `self` = self else { return }

			self.loader.stopAnimation(self)

			if let items = event.element {
				print("Reload data")
				self.market = items
				self.tableView.reloadData()
				self.notifyWhenCurrencyVariationAppear(currency: "Bitcoin")
				self.notifyWhenCurrencyVariationAppear(currency: "Litecoin")
			} else if !event.isCompleted {
				print("somethings wrong happen with the service")
			}
		}
	}

	func notifyWhenCurrencyVariationAppear(currency: String) {
		guard let currencyData = market.filter({ $0.name == currency }).first else {
			print("No \(currency) item in your list... How \(currency) could disappear... Another joke from Flipper the dolphin")
			return
		}

		guard let dailyPercentChange = currencyData.percentChange[.daily] else {
			return
		}

		let currentStatus = coinNotifaction[currency] ?? .none
		if abs(dailyPercentChange) > 5, currentStatus == .none {
			let notification = NSUserNotification()
			notification.title = "\(currency) News"
			notification.informativeText = "\(currency) has \(dailyPercentChange)% change"
			notification.soundName = NSUserNotificationDefaultSoundName
			NSUserNotificationCenter.default.deliver(notification)
			coinNotifaction[currency] = dailyPercentChange > 0 ? .up : .down
		} else if abs(dailyPercentChange) < 5, currentStatus != .none {
			let notification = NSUserNotification()
			notification.title = "\(currency) News"
			notification.informativeText = "\(currency) has \(dailyPercentChange)% change"
			notification.soundName = NSUserNotificationDefaultSoundName
			NSUserNotificationCenter.default.deliver(notification)
			coinNotifaction[currency] = .none
		}
	}
}
