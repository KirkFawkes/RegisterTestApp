//
//  RegisterViewController.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 29.09.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
	@IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
	
	let cellItems = [
		TableCellModel(title: NSLocalizedString("Email", comment: "Email title"), icon: "icon-email", keyboard: .emailAddress),
		TableCellModel(title: NSLocalizedString("Password", comment: "Password title"), icon: "icon-lock", secure: true),
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
//		let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
		let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
		self.updateView(keyboardVisible: true, animationDuration: duration)
	}
	
	func keyboardWillHide(notification: Notification) {
		let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
		self.updateView(keyboardVisible: false, animationDuration: duration)
	}
	
	// MARK: -
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "EditibleTableId") {
			let controller = segue.destination as! EditingTableViewController
			controller.cellModels = cellItems
		}
	}
	
	// MARK: - Helpers
	private func updateView(keyboardVisible: Bool, animationDuration duration: Double?) {
		let tableBottomConstraint: CGFloat = 162
		
		if (keyboardVisible) {
			tableViewBottomConstraint.constant = tableBottomConstraint + 120
		} else {
			tableViewBottomConstraint.constant = tableBottomConstraint
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
}

