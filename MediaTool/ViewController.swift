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
			do {
				tags = try MediaMetaData(file: first).tags
			} catch {
				DispatchQueue.main.async {
					_ = alert(message: "Unable to open file", text: error.localizedDescription + "\n" + first.relativePath)
				}
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		genericView.delegate = self
	}	
}
