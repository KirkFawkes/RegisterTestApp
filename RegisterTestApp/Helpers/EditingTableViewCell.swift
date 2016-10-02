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

protocol EditibleTableCellDelegate: class {
	func tableViewCellNext(cell: EditingTableViewCell)
	func tableViewCellChanged(cell: EditingTableViewCell)
}

class EditingTableViewCell: UITableViewCell, UITextFieldDelegate {
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var iconImageView: UIImageView!
	@IBOutlet private weak var textField: UITextField!
	
	@IBOutlet private weak var textFieldWidthConstraint: NSLayoutConstraint!
	
	var indexPath: IndexPath? = nil
	weak var delegate: EditibleTableCellDelegate?
	
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
			
			self.textField.returnKeyType = _isLast ? .done : .next
		}
	}
	
	var model: TableCellModel? {
		didSet {
			textField.text = nil
			iconImageView.image = nil
			titleLabel.text = nil;
			
			guard let model = self.model else {
				return
			}
			
			titleLabel.text = model.title
			textField.isSecureTextEntry = model.isSecure
			textField.keyboardType = model.keyboardType

			if let icon = model.icon {
				iconImageView.image = UIImage(named: icon)
			}
		}
	}
	
	var textValue: String? {
		get {
			return textField.text
		}
		
		set {
			textField.text = newValue
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
	
	@objc private func stopEditing() {
		self.textField.isUserInteractionEnabled = false
	}

	// MARK: - UITextFieldDelegate
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.delegate?.tableViewCellNext(cell: self)
		
		return false
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		// fix "bounces" up glich. 
		// See http://stackoverflow.com/questions/9674566/text-in-uitextfield-moves-up-after-editing-center-while-editing for details
		textField.layoutIfNeeded()
	}
	
	// MARK: UITextFieldDelegate
	func textFieldDidChange(sender: UITextField) {
		self.delegate?.tableViewCellChanged(cell: self)
	}
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		if !self.isSelected {
			self.setSelected(true, animated: true)
		}
		
		return true
	}
	
	// MARK: - Cell methods
    override func awakeFromNib() {
        super.awakeFromNib()
		
		self.textField.delegate = self
		self.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
		
		updateBorders()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		
		// NOTE: since we showing/hiding keyboard in this method (basically, cell is controling keyboard showing - not table/collection view)
		//       and this method called with "selected = false" for old cell and then "selected = true" for new cell, we can't just use
		//       self.textField.isUserInteractionEnabled = selected
		//       bcoz this may cause wrong move animation for all view, which must be changed when keyboard must show. So I just use
		//       timer to ensure that new text field alredy bacome as first responder
		if selected {
			NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(stopEditing), object: nil)
			self.textField.isUserInteractionEnabled = true
			self.textField.becomeFirstResponder()
		} else {
			self.perform(#selector(stopEditing), with: nil, afterDelay: 0.05)
		}
    }
}
