//
//  RegisterViewController.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 29.09.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
	let cellItems = [
		TableCellModel(title: NSLocalizedString("Email", comment: "Email title"), icon: "icon-email"),
		TableCellModel(title: NSLocalizedString("Password", comment: "Password title"), icon: "icon-lock"),
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "EditibleTableId") {
			let controller = segue.destination as! EditingTableView
			controller.cellModels = cellItems
		}
		
	}
}

