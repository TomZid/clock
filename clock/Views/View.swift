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
