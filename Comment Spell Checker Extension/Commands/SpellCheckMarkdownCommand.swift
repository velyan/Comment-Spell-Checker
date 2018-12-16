//
//  SpellCheckMarkdownCommand.swift
//  Comment Spell Checker Extension
//
//  Created by Velislava Yanchina on 15/12/18.
//  Copyright © 2018 Velislava Yanchina. All rights reserved.
//

import Foundation
import XcodeKit
import Cocoa

class SpellCheckMarkdownCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        let buffer = invocation.buffer
        let matchesMap = Parser.parseMarkDown(buffer.lines as! [String])
        
        for (idx, ranges) in matchesMap {
            guard let line = buffer.lines[idx] as? String else { continue }
            
            for range in ranges {
                guard let swiftRange = Range(range, in: line) else { continue }
                print("match \(line[swiftRange])")
            }
        }
        
        completionHandler(nil)
    }
}
