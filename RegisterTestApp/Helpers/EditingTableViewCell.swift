//
//  EditingTableViewCell.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 30.09.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import UIKit

private enum Border {
	static let name = "cell_border"
	static let size: CGFloat = 1.0
	static let color = UIColor(hex: 0xD8D8D8)
}

class EditingTableViewCell: UITableViewCell {
	private var _isLast = false
	var isLast: Bool {
		get {
			return _isLast
		}
		
		set {
			if (_isLast != newValue) {
				_isLast = newValue
				
				updateBorders()
			}
		}
	}
	
	var model: TableCellModel? {
		didSet {
			// TODO: update cell with this model
			print(model)
		}
	}
	
	// MARK: - Helpers
	private func updateBorders() {
		self.removeBorders(name: Border.name)
		
		self.addBorderTop(size: Border.size, color: Border.color, name: Border.name)
		
		if (_isLast) {
			self.addBorderBottom(size: Border.size, color: Border.color, name: Border.name)
		}
	}
	
	// MARK: - Cell methods
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		updateBorders()
		
//		self.backgroundColor = UIColor.rndColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
