//
//  Demo.swift
//  Comment Spell Checker Extension
//
//  Created by Velislava Yanchina on 24/11/18.
//  Copyright © 2018 Velislava Yanchina. All rights reserved.
//

import XcodeKit

/** A half-open range of text in a buffer. A range with equal start and end positions is used to indicate a point within the buffer, such as an insertion point. Otherwise, the range includes the character at the start position and excludes the character at the end position. The start and end may be improperly ordered transiently, but must be properly ordered before passing an XCSourceTextRange to other API. */
open class SourceTextRange {
    
    //The position representing the start of the range.
    open var start: XCSourceTextPosition
    
    /* The position representing the end of the range; the character at this position is not included within the range. */
    open var end: XCSourceTextPosition
    
    ///  Returns a range with the given start and end positions.
    ///  The start and end positions must be properly ordered.
    ///
    /// - Parmeters:
    ///   - start: A start position.
    ///   - end: An end position.
    public init(start: XCSourceTextPosition, end: XCSourceTextPosition) {
        self.start = start
        self.end = end
    }
}
