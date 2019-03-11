//
//  View.swift
//  clock
//
//  Created by tom on 2019/3/5.
//  Copyright © 2019 NWD. All rights reserved.
//

import UIKit

@IBDesignable
open class CornerRadiusView: UIView, CornerDesignable {
    @IBInspectable open var cornerRadius: CGFloat = CGFloat.nan {
        didSet {
            configureCornerRadius()
        }
    }
}

@IBDesignable
open class ProgressView: CornerRadiusView, Progress {

    @IBInspectable open var animated: Bool = true

    @IBInspectable open var remainingColor: UIColor = UIColor.blue

    @IBInspectable open var progressColor: UIColor = UIColor.yellow

    @IBInspectable open var axis: Axis = Axis(rawValue: 1)!

    @IBInspectable open var currentValue: CGFloat = CGFloat.nan {
        didSet {
            setCurrentValue(superview?.frame.size.height ?? self.frame.size.height)
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
