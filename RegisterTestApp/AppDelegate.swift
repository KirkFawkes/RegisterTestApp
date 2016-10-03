//
//  AppDelegate.swift
//  RegisterTestApp
//
//  Created by Igor Zubko on 29.09.16.
//  Copyright © 2016 Igor Zubko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func printFonts() {
		UIFont.familyNames.forEach { fontFamily in
			print("Font family: \(fontFamily)")
			
			let fontNames = UIFont.fontNames(forFamilyName: fontFamily)
			print("   names: \(fontNames)")
		}
	}
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//		printFonts()
		
		let font = UIFont(name: "SFUIText-Light", size: 14)
	
		let navBarAppearace = UINavigationBar.appearance()
		navBarAppearace.tintColor = UIColor.white
		navBarAppearace.barTintColor = UIColor(hex: 0x0AB8B4)
		navBarAppearace.isTranslucent = false
		navBarAppearace.titleTextAttributes = [
			NSForegroundColorAttributeName: UIColor.white,
			NSFontAttributeName: font!
		]
		
		let backButtonImage = UIImage(named: "back-button")?.withRenderingMode(.alwaysOriginal)
		UIBarButtonItem.appearance().setBackButtonBackgroundImage(backButtonImage, for: .normal, barMetrics: .default)
		
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

