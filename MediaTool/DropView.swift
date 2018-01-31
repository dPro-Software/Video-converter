//
//  DropView.swift
//  MediaTool
//
//  Created by Damiaan on 31/01/18.
//  Copyright © 2018 Devian. All rights reserved.
//

import Cocoa

protocol UrlHandler {
	func received(urls: [URL])
}

class VideoFileDropDestination: NSView {
	var underDraggingVideo = false
	var delegate: UrlHandler?
	
	override func awakeFromNib() {
		registerForDraggedTypes([.fileURL])
	}
	
	override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
		if VideoFileDropDestination.shouldAllow(drag: sender) {
			underDraggingVideo = true
			return .link
		} else {
			print("not a video")
			return []
		}
	}
	
	override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
		return VideoFileDropDestination.shouldAllow(drag: sender)
	}
	
	override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
		let objects = sender
			.draggingPasteboard()
			.readObjects(
				forClasses: [NSURL.self],
				options: VideoFileDropDestination.isMovie
			)
		guard let urls = objects as? [URL], urls.count > 0 else {
			return false
		}
		delegate?.received(urls: urls)
		underDraggingVideo = false
		return true
	}
	
	override func draggingExited(_ sender: NSDraggingInfo?) {
		underDraggingVideo = false
	}
	
	
	static let isMovie = [
		NSPasteboard.ReadingOptionKey.urlReadingContentsConformToTypes: ["public.movie"]
	]
	static func shouldAllow(drag: NSDraggingInfo) -> Bool {
		return drag.draggingPasteboard().canReadObject(
			forClasses: [NSURL.self],
			options: isMovie
		)
	}
}
