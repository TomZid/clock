//
//  ProgressDesignable.swift
//  clock
//
//  Created by tom on 2019/3/6.
//  Copyright © 2019 NWD. All rights reserved.
//

import UIKit

public enum Axis: Int {
    case horizontal
    case vertical
}

public protocol Progress {
    var totalSize: CGFloat! { get set }

    var valueStart: CGFloat { get set }
    var valueEnd: CGFloat { get set }
    var currentValue: CGFloat? { get set }

    var animated: Bool { get set }

    var remainingColor: UIColor { get set }
    var progressColor: UIColor { get set }

    var progressLayer: CALayer { get }

    var axis: Axis { get set }
}

extension Progress {

    func currentValue(_ value: CGFloat!) {
        
    }
}

public extension Progress where Self: UIView {
    public func setCurrentValue() {
        guard let currentValue = currentValue else {
            return
        }

        var rect = progressLayer.frame
        switch axis {
        case .horizontal:
            rect = CGRect(x: rect.origin.x, y: rect.origin.y, width: totalSize * currentValue, height: rect.size.height)
        case .vertical:
            rect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height:  totalSize * currentValue)
        }
    }
}
