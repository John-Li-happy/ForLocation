//
//  CustomCalloutViewNib.swift
//  ForLocation
//
//  Created by Zhaoyang Li on 7/14/20.
//  Copyright © 2020 Zhaoyang Li. All rights reserved.
//

import UIKit

class CustomCalloutViewNibs: UIView {
    
    @IBOutlet weak var bestlocationButton: UIButton!
    @IBOutlet weak var destinationButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var headShotImageView: UIImageView! 
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.isHidden = true
    }
    
}
