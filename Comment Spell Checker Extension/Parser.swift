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
    static let markdownLink = "(.*\\[.+\\](?=\\(.*\\)+))|((?<=\\)).*)"
    static let markdownText = ".*"

}

private extension NSRegularExpression {
    func matches(in input: String) -> [NSTextCheckingResult] {
        let range = NSRange(0 ..< input.count)
        return matches(in: input, options: .reportProgress, range: range)
    }
}


enum Parser {
    
    static func parseComments(_ buffer: [String]) -> IndexSet {
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
    
    static func parseMarkDown(_ buffer: [String]) -> [Int: [NSRange]] {
        var result: [Int: [NSRange]] = [:]
        guard let escapingLinkMatches = try? NSRegularExpression(pattern: Pattern.markdownLink,
                    
                                                         options: .caseInsensitive),
            let textMatches = try? NSRegularExpression(pattern: Pattern.markdownText,
                                                       
                                                       options: .caseInsensitive) else { return result }
     
        for (idx,line) in buffer.enumerated() {
            let matches = escapingLinkMatches.matches(in: line)
            if !matches.isEmpty {
                result[idx] = matches.map{ $0.range }
                print("link \(line)")
            } else {
                let textMatches = textMatches.matches(in: line)
                if !textMatches.isEmpty {
                    result[idx] = textMatches.map{ $0.range }
                    print("text \(line)")
                }
            }
        }
        
        return result
    }
}
