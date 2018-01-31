//
//  ViewController.swift
//  MediaTool
//
//  Created by Damiaan on 31/01/18.
//  Copyright © 2018 Devian. All rights reserved.
//

import Cocoa

class MainViewController: ViewController<VideoFileDropDestination>, UrlHandler {
	@objc dynamic var tags = [String:String]()
	
	func received(urls: [URL]) {
		if let first = urls.first {
			tags = MediaMetaData(file: first).tags
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		genericView.delegate = self
	}
}
