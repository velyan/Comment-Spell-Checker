//
//  SourceEditorCommand.swift
//  Comment Spell Checker Extension
//
//  Created by Velislava Yanchina on 24/11/18.
//  Copyright © 2018 Velislava Yanchina. All rights reserved.
//

import Foundation
import XcodeKit
import Cocoa

enum SpellCheckerError: Error {
    case unsupportedSource
}

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        let buffer = invocation.buffer
        let indices = Parser.parse(buffer.lines as! [String])
        
        let spellChecker = NSSpellChecker.shared
        let tag = NSSpellChecker.uniqueSpellDocumentTag()
        
        for idx in indices {
            guard var line = buffer.lines[idx] as? String else { continue }
            
            var range = NSRange(location: 0, length: 0)
            var startingIndex = 0
            
            while range.location != NSNotFound {
                range = spellChecker.checkSpelling(of: line,
                                                   startingAt: startingIndex,
                                                   language: spellChecker.language(),
                                                   wrap: false,
                                                   inSpellDocumentWithTag: tag,
                                                   wordCount: nil)
                
                guard range.location != NSNotFound else { break }
                
                if let correction = spellChecker.correction(forWordRange: range,
                                                            in: line,
                                                            language: spellChecker.language(),
                                                            inSpellDocumentWithTag: tag) {
                    
                    guard let swiftRange = Range(range, in: line) else { continue }
                    let corrected = line.replacingCharacters(in: swiftRange, with: correction)
                    
                    line = corrected
                }
                
                startingIndex = NSMaxRange(range)
            }
            
            buffer.lines[idx] = line
        }
        
        spellChecker.closeSpellDocument(withTag: tag)
        
        completionHandler(nil)
    }
}
