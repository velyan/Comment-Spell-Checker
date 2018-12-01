//
//  ExternalLinks.swift
//  Comment Spell Checker
//
//  Created by Velislava Yanchina on 1/12/18.
//  Copyright © 2018 Velislava Yanchina. All rights reserved.
//

import Foundation
import AppKit

enum ExternalLinks {
    
    static func openTwitterProfile() {
        open(url: "https://twitter.com/vel_is_lava")
    }
    
    static func openGitHubPage() {
        open(url: "https://github.com/velyan/Comment-Spell-Checker")
    }
    
    private static func open(url urlString: String) {
        if let url = URL(string: urlString) {
            NSWorkspace.shared.open(url)
        } else {
            print("Unable to construct url from string: \(urlString)")
        }
    }
}
