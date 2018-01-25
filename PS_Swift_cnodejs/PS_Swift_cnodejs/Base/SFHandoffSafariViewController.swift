//
//  SFHandoffSafariViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/17.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit
import SafariServices

class SFHandoffSafariViewController: SFSafariViewController {

    override public init(url URL: URL, entersReaderIfAvailable: Bool) {
        super.init(url: URL, entersReaderIfAvailable: entersReaderIfAvailable)
        if userActivity == nil {
            userActivity = NSUserActivity(activityType: NSUserActivityTypeBrowsingWeb)
        }
        userActivity?.webpageURL = URL
        delegate = self
    }
    
    convenience public init(url URL: URL) {
        self.init(url: URL, entersReaderIfAvailable: false)
    }
}

extension SFHandoffSafariViewController: SFSafariViewControllerDelegate {
    
    open func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        if didLoadSuccessfully {
            controller.userActivity?.becomeCurrent()
        }
    }
    
    open func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.userActivity?.resignCurrent()
    }
}
