//
//  DeleteViewController.swift
//  ForLocation
//
//  Created by Zhaoyang Li on 7/6/20.
//  Copyright © 2020 Zhaoyang Li. All rights reserved.
//

import UIKit

class DeleteViewController: UIViewController {
    
    @IBOutlet var trialView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        trialView.backgroundColor = .yellow
        trialView.isUserInteractionEnabled = true
        let customView = CustomCalloutView()
        trialView.addSubview(customView)
    }
    
    @objc func printStuff() {
        print("this is it")
    }


}
