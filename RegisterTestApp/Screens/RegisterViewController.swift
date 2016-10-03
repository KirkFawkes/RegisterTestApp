//
//  RegisterViewController.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 29.09.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, EditingTableViewControllerDelegate {
	weak var editingTable: EditingTableViewController? = nil
	@IBOutlet weak var loginButton: ControlButton!
	@IBOutlet weak var loginButtonBottomConstraint: NSLayoutConstraint!
	
	let cellModels = [
		TableCellModel(title: NSLocalizedString("Email",    comment: "Email title"),    icon: "icon-email", type: .email),
		TableCellModel(title: NSLocalizedString("Password", comment: "Password title"), icon: "icon-lock",  type: .password),
	]
	
	var email: String {
		set {
			self.editingTable!.values[0] = newValue
		}
		
		get {
			return self.editingTable!.values[0]
		}
	}
	
	var password: String {
		set {
			self.editingTable!.values[1] = newValue
		}
		
		get {
			return self.editingTable!.values[1]
		}
	}
	
	var config: Config? = nil
	
	// MARK - View methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.loadingIndicator(enabled: true)
		
		Config.load { config in
			self.loadingIndicator(enabled: false)
			self.config = config
			
			if let info = config.authorizationInfo {
				self.email = info.email
				self.password = info.password
				self.validateAndUpdateUI()
			}
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
		
		self.validateAndUpdateUI()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		NotificationCenter.default.removeObserver(self)
		
		super.viewDidDisappear(animated)
	}
	
	// MARK: - Keyboard events
	func keyboardWillShow(notification: Notification) {
		let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
		let height = keyboardFrame.size.height
		
		let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
		updateUI(keyboardVisible: true, keyboardHeight: height, animationDuration: duration)
	}
	
	func keyboardWillHide(notification: Notification) {
		let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
		updateUI(keyboardVisible: false, keyboardHeight: 0, animationDuration: duration)
	}
	
	// MARK: -
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "EditibleTableId") {
			assert(self.editingTable == nil)
			
			let controller = segue.destination as! EditingTableViewController
			controller.models = cellModels
			controller.delegate = self
			
			self.editingTable = controller
			
		} else if segue.identifier == "userInfoSegueId" {
			let controller = segue.destination as! UserInfoViewController
			controller.config = self.config
		}
	}
	
	// MARK: - EditingTableViewControllerDelegate
	func editingTable(table: EditingTableViewController, model: TableCellModel, changedTo value: String?) {
		validateAndUpdateUI()
	}
	
	func editintTableDone(table: EditingTableViewController) {
		if isValidInput() {
			self.loginAction(self)
		}
	}
	
	// MARK: - Helpers
	private func updateUI(keyboardVisible: Bool, keyboardHeight: CGFloat, animationDuration duration: Double?) {
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
	
	private func isValidInput() -> Bool {
		return self.password.isValidPassword() && self.email.isValidEmail()
	}
	
	private func validateAndUpdateUI() {
		self.loginButton.isEnabled = isValidInput()
	}
	
	// MARK: - Actions
	@IBAction func loginAction(_ sender: AnyObject) {
		let email = self.email
		let paaword = self.password
		
		assert(email.characters.count > 0)
		assert(paaword.characters.count > 0)
		
		let config = self.config!
		config.authorizationInfo = AuthorizationInfo(email: email, password: password)
		config.userInfo = nil
		
		self.loadingIndicator(enabled: true)
		config.save {
			self.loadingIndicator(enabled: false)
			
			NSLog("User credentials saved")
			
			self.performSegue(withIdentifier: "userInfoSegueId", sender: self)
		}
	}
}
