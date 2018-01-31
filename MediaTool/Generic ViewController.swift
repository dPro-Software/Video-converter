//
//  Generic ViewController.swift
//  MediaTool
//
//  Created by Damiaan on 31/01/18.
//  Copyright © 2018 Devian. All rights reserved.
//

import Cocoa

class ViewController<ViewType: NSView>: NSViewController {
	var genericView: ViewType {
		return view as! ViewType
	}
}
