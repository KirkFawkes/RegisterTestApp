//
//  RegisterViewController.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 29.09.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
	@IBOutlet weak var loginButtonBottomConstraint: NSLayoutConstraint!
	
	@IBOutlet weak var loginButton: ControlButton!
	
	let cellItems = [
		TableCellModel(title: NSLocalizedString("Email", comment: "Email title"), icon: "icon-email", type: .email),
		TableCellModel(title: NSLocalizedString("Password", comment: "Password title"), icon: "icon-lock", type: .password),
	]
	
	// MARK - View methods
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		NotificationCenter.default.removeObserver(self)
		
		super.viewDidDisappear(animated)
	}
	
	// MARK: - Keyboard
	func keyboardWillShow(notification: Notification) {
		let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
		let height = keyboardFrame!.size.height
		
		let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
		self.updateView(keyboardVisible: true, keyboardHeight: height, animationDuration: duration)
	}
	
	func keyboardWillHide(notification: Notification) {
		let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
		self.updateView(keyboardVisible: false, keyboardHeight: 0, animationDuration: duration)
	}
	
	// MARK: -
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "EditibleTableId") {
			let controller = segue.destination as! EditingTableViewController
			controller.models = cellItems
			controller.delegate = self
		}
	}
	
	// MARK: - Helpers
	private func updateView(keyboardVisible: Bool, keyboardHeight: CGFloat, animationDuration duration: Double?) {
		let loginButtonConstraint: CGFloat = 16
		
		if (keyboardVisible) {
			loginButtonBottomConstraint.constant = loginButtonConstraint + keyboardHeight
		} else {
			loginButtonBottomConstraint.constant = loginButtonConstraint
		}
		
		let animationBlock: () -> Void = { [unowned self] in
			self.view.setNeedsLayout()
			self.view.layoutIfNeeded()
		}
		
		if (duration == nil) {
			animationBlock()
		} else {
			UIView.animate(withDuration: duration!, animations: animationBlock)
		}
	}
	
	func validateInputData(values: [String]) -> Bool {
//		let result = zip(self.cellItems.map({ $0.type }), values)
//
//		for (type, value) in result {
//		
//		}
		
		return false
	}
}

extension RegisterViewController: EditingTableViewControllerDelegate {
	func editingTable(table: EditingTableViewController, model: TableCellModel, changedTo value: String?) {
		let validationResult = self.validateInputData(values: table.values)
		print("Validation result: \(validationResult)")
	}
	
	func editintTableDone(table: EditingTableViewController) {
		print("Editing finished")
	}
}

