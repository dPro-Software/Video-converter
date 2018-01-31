//
//  AppDelegate.swift
//  MediaTool
//
//  Created by Damiaan on 31/01/18.
//  Copyright © 2018 Devian. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {}

func alert(message: String, text: String) -> Bool {
	let alert = NSAlert()
	alert.messageText = message
	alert.informativeText = text
	alert.alertStyle = .critical
	alert.addButton(withTitle: "OK")
	return alert.runModal() == .alertFirstButtonReturn
}
