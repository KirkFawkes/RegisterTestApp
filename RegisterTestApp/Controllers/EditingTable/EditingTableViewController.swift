//
// Created by Igor Zubko on 30.09.16.
// Copyright (c) 2016 Igor Zubko. All rights reserved.
//
import UIKit

protocol EditingTableViewControllerDelegate: class {
	func editingTable(table: EditingTableViewController, model: TableCellModel, changedTo value: String?)
	func editintTableDone(table: EditingTableViewController)
}

class EditingTableViewController: UITableViewController, EditibleTableCellDelegate {
	private var cellValues = [String]()
	
	var models = [TableCellModel]() {
		didSet {
			self.cellValues = [String](repeating: "", count: models.count)
			self.tableView.reloadData()
		}
	}
	
	var values: [String] {
		get {
			return self.cellValues
		}
		
		set {
			assert(newValue.count == models.count, "Values count must be equal to models count")
			
			self.cellValues = newValue
			self.tableView.reloadData()
		}
	}
	
	weak var delegate: EditingTableViewControllerDelegate? = nil
	
	// MARK: - UITableViewDataSource
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let rows = self.tableView(tableView, numberOfRowsInSection: indexPath.section)
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "textCellId", for: indexPath) as! EditingTableViewCell
		cell.isLast = (indexPath.row == rows - 1)
		cell.model = self.models[indexPath.row]
		cell.textValue = self.cellValues[indexPath.row]
		cell.delegate = self
		cell.indexPath = indexPath
		
		return cell
	}
	
	// MARK: - EditibleTableCellDelegate
	func tableViewCellNext(cell: EditingTableViewCell) {
		let indexPath = self.tableView.indexPath(for: cell)!
		let tableView = self.tableView!
		
		if (cell.isLast) {
			tableView.deselectRow(at: indexPath, animated: true)
			delegate?.editintTableDone(table: self)
		} else {
			let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
			let cellIsVisible = tableView.indexPathsForVisibleRows.map { $0.contains(nextIndexPath) } ?? false
			let scroll: UITableViewScrollPosition = cellIsVisible ? .none : .middle

			tableView.selectRow(at: nextIndexPath, animated: true, scrollPosition: scroll)
		}
	}
	
	func tableViewCellChanged(cell: EditingTableViewCell) {
		let index = cell.indexPath!.row
		let text = cell.textValue ?? ""
		
		self.cellValues[index] = text
		delegate?.editingTable(table: self, model: models[index], changedTo: text)
	}
}
