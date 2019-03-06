//
//  CornerDesignable.swift
//  clock
//
//  Created by tom on 2019/3/5.
//  Copyright © 2019 NWD. All rights reserved.
//

import UIKit

public protocol CornerDesignable {
    var cornerRadius: CGFloat { get set }
}

extension CornerDesignable {
    func configureCornerRadius(in view: UIView) {
        guard !cornerRadius.isNaN && cornerRadius > 0 else {
            return
        }
        applyCorner(in: view)
    }

    func applyCorner(in view: UIView) {
        view.layer.cornerRadius = cornerRadius
    }

}

public extension CornerDesignable where Self: UIView {
    public func configureCornerRadius() {
        configureCornerRadius(in: self)
    }
}
