//
//  AppDelegate.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 5/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		IQKeyboardManager.shared.enable = true;
		IQKeyboardManager.shared.enableAutoToolbar = true;
		IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
		IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = true;
		IQKeyboardManager.shared.toolbarDoneBarButtonItemText = Translations.Done
		
		let pageControl = UIPageControl.appearance()
		pageControl.pageIndicatorTintColor = Constants.Colors.field(darkMode: true).color
		pageControl.currentPageIndicatorTintColor = Constants.Colors.about(darkMode: true).color
		pageControl.backgroundColor = Constants.Colors.field(darkMode: false).color
		
		IOC.container = IOC.RegisterElements()
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}

