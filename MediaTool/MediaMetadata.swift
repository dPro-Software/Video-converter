//
//  MediaMetadata.swift
//  MediaTool
//
//  Created by Damiaan on 31/01/18.
//  Copyright © 2018 Devian. All rights reserved.
//

struct MediaMetaData {
	enum Error: Swift.Error {
		case couldNotOpenFile(reason: String)
	}
	
	let tags: [String:String]
	
	init(file: URL) throws {
		var context: UnsafeMutablePointer<AVFormatContext>?
		var tag: UnsafeMutablePointer<AVDictionaryEntry>?
		
		var tags = [String: String]()
		
		av_register_all()
		let result = file.path.cString(using: .utf8)!.withUnsafeBufferPointer {
			avformat_open_input(&context, $0.baseAddress, nil, nil)
		}
		guard result == 0 else {
			var descriptionBytes = [Int8](repeating: 0, count: 100)
			let error = descriptionBytes.withUnsafeMutableBufferPointer {
				av_strerror(result, $0.baseAddress, 100)
			}
			let description: String
			if error == 0 {
				description = String(cString: descriptionBytes)
			} else {
				description = "AVERROR \(result)"
			}
			throw Error.couldNotOpenFile(reason: description)
		}
		
		let emptyString = [Int8(0)]
		while true {
			tag = av_dict_get(context!.pointee.metadata, emptyString, tag, AV_DICT_IGNORE_SUFFIX)
			guard let pointee = tag?.pointee else { break }
			tags[String(cString: pointee.key)] = String(cString: pointee.value)
		}
		self.tags = tags
		
		avformat_close_input(&context)
	}
}

extension MediaMetaData.Error: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .couldNotOpenFile(reason: let reason):
			return reason
		}
	}
}
