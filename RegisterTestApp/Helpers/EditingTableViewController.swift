//
// Created by Igor Zubko on 30.09.16.
// Copyright (c) 2016 Igor Zubko. All rights reserved.
//
import UIKit

class EditingTableViewController: UITableViewController, EditibleTableCellDelegate {
	var cellModels = [TableCellModel]() {
		didSet {
			self.tableView.reloadData()
		}
	}

	// MARK: - UITableViewDataSource
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellModels.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let rows = self.tableView(tableView, numberOfRowsInSection: indexPath.section)
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "textCellId", for: indexPath) as! EditingTableViewCell
		cell.isLast = (indexPath.row == rows - 1)
		cell.model = cellModels[indexPath.row]
		cell.delegate = self
		
		return cell
	}
	
	// MARK: - EditibleTableCellDelegate
	func tableViewCellNext(cell: EditingTableViewCell) {
		let indexPath = self.tableView.indexPath(for: cell)!
		let tableView = self.tableView!
		
		if (cell.isLast) {
			tableView.deselectRow(at: indexPath, animated: true)
		} else {
			let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
			let cellIsVisible = tableView.indexPathsForVisibleRows.map { $0.contains(nextIndexPath) } ?? false
			let scroll: UITableViewScrollPosition = cellIsVisible ? .none : .middle

			tableView.selectRow(at: nextIndexPath, animated: true, scrollPosition: scroll)
		}
	}
}
