//
//  UIViewController.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 03.10.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import UIKit

private let indicatorTag: Int = 1255483
private let showDelay: TimeInterval = 0.125

extension UIViewController {
	
	// add simple loading indicator
	func loadingIndicator(enabled: Bool) {
		if enabled {
			self.perform(#selector(showLoadingIndicator), with: nil, afterDelay: showDelay)
		} else {
			NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(showLoadingIndicator), object: nil)
			hideLoadingIndicator()
		}
		
		self.view.isUserInteractionEnabled = !enabled
	}
	
	@objc private func showLoadingIndicator() {
		if self.view.viewWithTag(indicatorTag) != nil {
			return
		}
		
		// initialize background view for indicator
		let view = UIView(frame: self.view.bounds)
		view.tag = indicatorTag
		view.backgroundColor = UIColor.black
		view.alpha = 0.0
		
		// initialize activity indicator
		let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		indicator.startAnimating()
		indicator.center = view.center
		
		// configure display this indicator view
		view.addSubview(indicator)
		self.view.addSubview(view)
		
		UIView.animate(withDuration: 0.25) {
			view.alpha = 0.5
		}
	}
	
	@objc private func hideLoadingIndicator() {
		guard let indicatorView = self.view.viewWithTag(indicatorTag) else {
			return
		}
		
		UIView.animate(withDuration: 0.25, animations: {
			indicatorView.alpha = 0.0
		}, completion: { _ in
			indicatorView.removeFromSuperview()
		})
	}
}
