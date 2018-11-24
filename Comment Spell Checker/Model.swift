//
//  Model.swift
//  SpellChecker
//
//  Created by Velislava Yanchina on 17/11/18.
//  Copyright © 2018 Velislava Yanchina. All rights reserved.
//

import Foundation

typealias ResourceTuple = (name: String, extension: String)

struct Content {
    var title: String
    var description: String
    var resource: ResourceTuple
}

protocol NavigationItemProtocol {
    var title: String {get set}
}

struct NavigationItem: NavigationItemProtocol{
    internal var title: String
}

struct HeaderNavigationItem : NavigationItemProtocol {
    internal var title: String
}
