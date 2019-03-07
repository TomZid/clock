//
//  BrightnessIndexView.swift
//  clock
//
//  Created by tom on 2019/3/7.
//  Copyright © 2019 NWD. All rights reserved.
//

import UIKit

class BrightnessIndexView: UIViewController {

    @IBOutlet weak var progressView: ProgressView!

    func currentProgress(_ progress: CGFloat) {
        self.progressView.currentValue = progress
    }
}
