//
//  ViewController.swift
//  hf_client
//
//  Created by Roman Figurin on 26/11/2017.
//  Copyright © 2017 Roman Figurin. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let damaged = Notification.Name("damaged")
    static let ok = Notification.Name("ok")
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setToDamaged(notification:)),
                                               name: .damaged,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setToOk(notification:)),
                                               name: .ok,
                                               object: nil)
        
        NetworkManager.makeGetCall()
    }

    // handlers
    @objc func setToDamaged(notification: NSNotification) {
        print("damaged notification")
    }

    @objc func setToOk(notification: NSNotification) {
        print("ok notification")
    }

}

