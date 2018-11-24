//
//  HelpContainerViewController.swift
//  Mark
//
//  Created by Velislava Yanchina on 10/24/16.
//  Copyright © 2016 Velislava Yanchina. All rights reserved.
//

import Cocoa
import AVKit
import AVFoundation

class HelpContentViewController: NSViewController, HelpControllerDelegate {
    
    @IBOutlet weak var videoPlayer: AVPlayerView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var descriptionLabel: NSTextField!
    
    fileprivate func configurePlayer(withResource resource: ResourceTuple) {
        let url = Bundle.main.url(forResource: resource.name, withExtension: resource.extension)!
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.play()
        
        videoPlayer.player = player
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loop(with:)),
                                               name: Notification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem!)
    }
    
    @objc fileprivate func loop(with notification: Notification) {
        let item = notification.object as! AVPlayerItem
        item.seek(to: .zero, completionHandler: nil)
    }
    
    //MARK: HelpControllerDelegate
    func reloadContent(content: Content) {
        configurePlayer(withResource: content.resource)
        titleLabel.stringValue = content.title
        descriptionLabel.stringValue = content.description
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
