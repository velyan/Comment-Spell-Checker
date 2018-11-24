//
//  HelpController.swift
//  Comment Spell Checker
//
//  Created by Velislava Yanchina on 10/24/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Foundation

fileprivate enum Strings {
    static let installation = "Installation"
    static let keyBindingsSetup = "Key Bindings Setup"
    static let howToSetUp = "HOW TO SETUP"
    static let howToUse = "HOW TO USE"
    static let extensionName = "Comment Spell Checker"

    static let installationDescription = """
1. Open System Preferences
2. Select Extensions > Xcode Source Editor
3. Enable Comment Spell Checker
"""
    static let keyBindingsDescription = """
1. Open Xcode > Preferences
2. Select Key Bindings from the top bar
3. Filter by \"comment spell checker\" and double tap the result to edit key bindings
"""
    static let description = "When in Xcode select Editor > Comment Spell Checker > Spell Check Comments"
}

fileprivate enum Resources {
    static let installation = (name: "system_prefs_demo", extension: "mov")
    static let keyBindings = (name: "key_bindings_demo", extension: "mov")
    static let demo = (name: "demo", extension: "mov")
}

fileprivate enum Contents {
    static let installation = Content(title: Strings.installation,
                                      description: Strings.installationDescription,
                                      resource: Resources.installation)
    static let keyBindings = Content(title: Strings.keyBindingsSetup,
                                     description: Strings.keyBindingsDescription,
                                     resource: Resources.keyBindings)
    static let demo = Content(title: Strings.extensionName,
                              description: Strings.description,
                              resource: Resources.demo)
}

protocol HelpControllerDelegate: class {
    func reloadContent(content: Content)
}

class HelpController {
    weak var delegate: HelpControllerDelegate?
    lazy var data = [HeaderNavigationItem(title: Strings.howToSetUp),
                     NavigationItem(title: Strings.installation),
                     NavigationItem(title: Strings.keyBindingsSetup),
                     HeaderNavigationItem(title: Strings.howToUse),
                     NavigationItem(title: Strings.extensionName)] as [Any]
    
    public func action(forItem item: NavigationItemProtocol) {
        if let content = content(forNavigationItem: item) {
            delegate?.reloadContent(content: content)
        }
    }
    
    func content(forNavigationItem item: NavigationItemProtocol) -> Content? {
        if item.title == Strings.installation {
            return Contents.installation
        }
        else if item.title == Strings.keyBindingsSetup {
            return Contents.keyBindings
        }
        else if item.title == Strings.extensionName {
            return Contents.demo
        }
        return nil
    }
}
