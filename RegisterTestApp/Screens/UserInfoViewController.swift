//
//  UserInfoViewController.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 03.10.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController, EditingTableViewControllerDelegate {
	var config: Config? = nil
	
	let cellModels = [
		TableCellModel(title: NSLocalizedString("Email",      comment: "Email title"),      icon: "icon-email", type: .email),
		TableCellModel(title: NSLocalizedString("Password",   comment: "Password title"),   icon: "icon-lock",  type: .password),
		TableCellModel(title: NSLocalizedString("First Name", comment: "first name title"), icon: "icon-name",  type: .firstName),
		TableCellModel(title: NSLocalizedString("Last Name",  comment: "last name title"),  icon: "icon-name",  type: .lastName),
	]
	
	var cellValueAuthInfo: AuthorizationInfo? {
		get {
			let values = self.tableView!.values
			return AuthorizationInfo(email: values[0], password: values[1])
		}
	}
	
	var tableView: EditingTableViewController? = nil
	
	@IBOutlet var saveButton: UIBarButtonItem!
	@IBOutlet var cancelButton: UIBarButtonItem!
	@IBOutlet var editButton: UIBarButtonItem!
	@IBOutlet var backButton: UIBarButtonItem!
	
	var isReadOnly: Bool {
		get {
			return self.tableView!.isReadonly
		}
		
		set {
			self.tableView!.isReadonly = newValue
			self.updateToolbarButtons()
		}
	}
	
	// MARK: - View controller lifetime
	override func viewDidLoad() {
		super.viewDidLoad()
		
		assert(self.config != nil)
		
		self.navigationItem.backBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: nil, action: nil)
		self.isReadOnly = true
		
		self.reloadData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.navigationController?.setNavigationBarHidden(false, animated: true)
		self.updateToolbarButtons()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		if self.navigationController?.viewControllers.index(of: self) == nil {
			self.navigationController?.setNavigationBarHidden(true, animated: true)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "userInfoTable" {
			let controller = segue.destination as! EditingTableViewController
			controller.models = cellModels
			controller.delegate = self
			
			self.tableView = controller
		}
	}
	
	// MARK: - Helpers
	func updateToolbarButtons() {
		if self.tableView!.isReadonly {
			self.navigationItem.rightBarButtonItems = [editButton]
			self.navigationItem.leftBarButtonItems = [backButton]
		} else {
			self.navigationItem.rightBarButtonItems = [saveButton]
			self.navigationItem.leftBarButtonItems = [cancelButton]
		}
	}
	
	func getInitialValues() -> [String] {
		let authInfo = self.config!.authorizationInfo
		let userInfo = self.config!.userInfo
		
		return [
			authInfo?.email ?? "",
			authInfo?.password ?? "",
			
			userInfo?.firstName ?? "",
			userInfo?.lastName ?? ""
		]
	}
	
	func reloadData() {
		self.tableView!.values = getInitialValues()
	}
	
	private func isValidInput() -> Bool {
		guard let auth = self.cellValueAuthInfo else {
			return false
		}
		
		return auth.password.isValidPassword() && auth.email.isValidEmail()
	}
	
	private func validateAndUpdateUI() {
		self.saveButton!.isEnabled = isValidInput()
	}
	
	// MARK: - EditingTableViewControllerDelegate
	func editingTable(table: EditingTableViewController, model: TableCellModel, changedTo value: String?) {
		self.validateAndUpdateUI()
	}
	
	func editintTableDone(table: EditingTableViewController) {
	}
	
	// MARK: - Actions
	@IBAction func actEdit(_ sender: AnyObject) {
		self.isReadOnly = false
		self.validateAndUpdateUI()
	}

	@IBAction func actSave(_ sender: AnyObject) {
		self.isReadOnly = true
		self.loadingIndicator(enabled: true)
		
		let values = self.tableView!.values

		assert(values.count == cellModels.count)
		
		let auth = AuthorizationInfo(email: values[0], password: values[1])
		let userInfo = UserInfo(firstName: values[2], lastName: values[3])
		
		self.config!.authorizationInfo = auth
		self.config!.userInfo = userInfo
		
		self.config!.save { 
			self.loadingIndicator(enabled: false)
		}
	}
	
	@IBAction func actCancel(_ sender: AnyObject) {
		self.isReadOnly = true
		self.reloadData()
	}
	
	@IBAction func actBack(_ sender: AnyObject) {
		self.loadingIndicator(enabled: true)
		
		self.config!.clear()
		self.config?.save(callback: { 
			self.loadingIndicator(enabled: true)
			
			let _ = self.navigationController?.popViewController(animated: true)
		})
	}
}
