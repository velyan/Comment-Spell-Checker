//
//  Parser.swift
//  SpellCheckerExtension
//
//  Created by Velislava Yanchina on 5/11/18.
//  Copyright © 2018 Velislava Yanchina. All rights reserved.
//

import Foundation
import XcodeKit

private enum Pattern {
    static let commentLine = "(\\/\\/|\\/\\/\\/)(.*)"
    static let commentStart = "(\\/\\*)(.*)"
    static let commentEnd =  "(\\*\\/)"
}

private extension NSRegularExpression {
    func matches(in input: String) -> [NSTextCheckingResult] {
        let range = NSRange(0 ..< input.count)
        return matches(in: input, options: .reportProgress, range: range)
    }
}


enum Parser {
    
    static func parse(_ buffer: [String]) -> IndexSet {
        guard let lineRegex = try? NSRegularExpression(pattern: Pattern.commentLine,
                                                       options: .caseInsensitive),
            let startRegex = try? NSRegularExpression(pattern: Pattern.commentStart,
                                                      options: .caseInsensitive),
            let endRegex = try? NSRegularExpression(pattern: Pattern.commentEnd,
                                                    options: .caseInsensitive) else { return IndexSet() }
        
        var stack: [Bool] = []
        var indices = IndexSet()

        for (idx,line) in buffer.enumerated() {
            print(line)

            let startMatches = startRegex.matches(in: line)
            startMatches.forEach{ _ in stack.append(true) }
            
            if !stack.isEmpty || !lineRegex.matches(in: line).isEmpty {
                indices.insert(idx)
            }
            
            let endMatches = endRegex.matches(in: line)
            endMatches.forEach{ _ in _ = stack.popLast() }
        }
        
        
        return indices
    }
}
