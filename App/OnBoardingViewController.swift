//
//  OnBoardingViewController.swift
//  Up N Down
//
//  Created by Thomas Paul Mann on 24/10/2016.
//  Copyright © 2016 Thomas Paul Mann. All rights reserved.
//

import Cocoa

class OnBoardingViewController: NSViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
    }

    override func viewWillAppear() {
        super.viewWillAppear()

        view.layer?.backgroundColor = NSColor.primaryBlue.cgColor
    }
    
}
