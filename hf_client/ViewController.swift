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
        
        makeNetworkCall()
        runTimer()
    }

    // handlers
    @objc func setToDamaged(notification: NSNotification) {
        print("damaged notification")
        
        DispatchQueue.main.async {
            self.removeSubviewAndSubcontrollers()
            let damagedVC: DamagedVC = DamagedVC()
            self.view.addSubview(damagedVC.view)
            self.addChildViewController(damagedVC)
        }
        
        
    }

    @objc func setToOk(notification: NSNotification) {
        print("ok notification")
        DispatchQueue.main.async {
            self.removeSubviewAndSubcontrollers()
            let cargoIsOkVC: CargoIsOkVC = CargoIsOkVC()
            self.view.addSubview(cargoIsOkVC.view)
            self.addChildViewController(cargoIsOkVC)
        }
    }

    // helpers
    func removeSubviewAndSubcontrollers() {
        for controller in self.childViewControllers {
            controller.view.removeFromSuperview()
            controller.removeFromParentViewController()
        }
    }
    
    func runTimer() {
        var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 10,
                                     target: self,
                                     selector: (#selector(ViewController.makeNetworkCall)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func makeNetworkCall() {
        NetworkManager.makeGetCall()
    }
}

