//
//  ViewController.swift
//  Comment Spell Checker
//
//  Created by Velislava Yanchina on 10/20/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Cocoa

class HelpSourceViewController: NSViewController {
    @IBOutlet weak var sourceListView: NSOutlineView!
    var controller: HelpController?
    
    override func viewDidAppear() {
        super.viewDidAppear()
        sourceListView.selectRowIndexes(IndexSet(integer: 1), byExtendingSelection: false)
    }
}

extension HelpSourceViewController: NSOutlineViewDelegate, NSOutlineViewDataSource {
    //MARK: NSOutlineViewDelegate
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        if let navigationItem = item as? NavigationItem {
            return configureCell(with: "DataCell", for: navigationItem)
        } else {
            return configureCell(with: "HeaderCell", for: (item as! HeaderNavigationItem))
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        return ((item as? NavigationItem) != nil)
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard let outlineView = notification.object as? NSOutlineView else {
            return
        }
        let selectedIndex = outlineView.selectedRow
        if let item = outlineView.item(atRow: selectedIndex) as? NavigationItem {
            controller?.action(forItem: item)
        }
    }
    
    func configureCell(with identifer: String, for item: NavigationItemProtocol) -> NSTableCellView? {
        var view: NSTableCellView?
        view = sourceListView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: identifer), owner: self) as? NSTableCellView
        if let textField = view?.textField {
            textField.stringValue = item.title
        }
        return view
    }

    //MARK: NSOutlineViewDataSource
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        return (controller?.data.count)!
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        return controller?.data[index] as Any
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return false
    }
    
}

