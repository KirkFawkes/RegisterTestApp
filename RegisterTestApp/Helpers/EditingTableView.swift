//
// Created by Igor Zubko on 30.09.16.
// Copyright (c) 2016 Igor Zubko. All rights reserved.
//

import UIKit

class EditingTableView: UITableViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let rows = self.tableView(tableView, numberOfRowsInSection: indexPath.section)
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "textCellId", for: indexPath) as! EditingTableViewCell
		cell.isLast = (indexPath.row == rows - 1)
		
		return cell
	}

	// MARK: - delegate

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Selected row %@", indexPath)
	}
}
