//
//  LoadingVC.swift
//  hf_client
//
//  Created by Roman Figurin on 26/11/2017.
//  Copyright © 2017 Roman Figurin. All rights reserved.
//

import UIKit

class LoadingVC: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activityIndicator.startAnimating()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.activityIndicator.stopAnimating()
    }
}
