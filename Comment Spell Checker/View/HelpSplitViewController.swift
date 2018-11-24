//
//  HelpSplitViewController.swift
//  Mark
//
//  Created by Velislava Yanchina on 10/24/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Cocoa

class HelpSplitViewController: NSSplitViewController {
    
    override func viewDidLoad() {
        configureSlitItems()
        super.viewDidLoad()
    }
    
    func configureSlitItems() {
        let contentViewController = splitViewItems.last?.viewController as! HelpContentViewController
        let sourceListViewController = self.splitViewItems.first?.viewController as! HelpSourceViewController
        let dataController = HelpController()
        dataController.delegate = contentViewController
        sourceListViewController.controller = dataController
    }
}
