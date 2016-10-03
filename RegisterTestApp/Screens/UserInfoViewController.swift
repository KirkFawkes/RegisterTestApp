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
	
	var initialValues: [String] = []
	
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
		assert(self.tableView != nil)
		
		let authInfo = config!.authorizationInfo
		
		self.initialValues = [
			authInfo?.email ?? "",
			authInfo?.password ?? "",
			"",
			""
		]
		
		self.navigationItem.backBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: nil, action: nil)
		self.isReadOnly = true
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
	
	// MARK: - EditingTableViewControllerDelegate
	func editingTable(table: EditingTableViewController, model: TableCellModel, changedTo value: String?) {
		print("Changed to", value)
	}
	
	func editintTableDone(table: EditingTableViewController) {
		print("Done")
	}
	
	// MARK: - Actions
	@IBAction func actEdit(_ sender: AnyObject) {
		self.isReadOnly = false
	}

	@IBAction func actSave(_ sender: AnyObject) {
		self.isReadOnly = true
	}
	
	@IBAction func actCancel(_ sender: AnyObject) {
		self.isReadOnly = true
	}
	
	@IBAction func actBack(_ sender: AnyObject) {
		let _ = self.navigationController?.popViewController(animated: true)
	}
	
}
