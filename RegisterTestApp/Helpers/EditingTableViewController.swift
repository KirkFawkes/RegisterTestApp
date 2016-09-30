//
// Created by Igor Zubko on 30.09.16.
// Copyright (c) 2016 Igor Zubko. All rights reserved.
//
import UIKit

class EditingTableViewController: UITableViewController {
	var cellModels = [TableCellModel]() {
		didSet {
			self.tableView.reloadData()
		}
	}

	// MARK: - Data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellModels.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let rows = self.tableView(tableView, numberOfRowsInSection: indexPath.section)
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "textCellId", for: indexPath) as! EditingTableViewCell
		cell.isLast = (indexPath.row == rows - 1)
		cell.model = cellModels[indexPath.row]
		
		return cell
	}

	// MARK: - delegate
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Selected row %@", indexPath)
	}
}
