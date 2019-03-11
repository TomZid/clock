//
//  ProgressDesignable.swift
//  clock
//
//  Created by tom on 2019/3/6.
//  Copyright © 2019 NWD. All rights reserved.
//

import UIKit

@objc
public enum Axis: Int {
    case horizontal
    case vertical
}

public protocol Progress {
    var currentValue: CGFloat { get set }

    var animated: Bool { get set }

    var remainingColor: UIColor { get set }
    var progressColor: UIColor { get set }

    var axis: Axis { get set }
}

public extension Progress {
    func currentValue(_ view: UIView, _ originSize: CGFloat) {
        var rect = view.frame
        switch axis {
        case .horizontal:
            rect = CGRect(x: rect.origin.x, y: rect.origin.y, width: originSize * currentValue, height: rect.size.height)
        case .vertical:
            rect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height:  originSize * currentValue)
        }
        view.frame = rect
    }
}

public extension Progress where Self: UIView {

    public func setCurrentValue(_ originSize: CGFloat) {
        currentValue(self, originSize)
    }
}
