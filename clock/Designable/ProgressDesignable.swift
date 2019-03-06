//
//  ProgressDesignable.swift
//  clock
//
//  Created by tom on 2019/3/6.
//  Copyright © 2019 NWD. All rights reserved.
//

import UIKit

public protocol Progress {
    var valueStart: CGFloat { get set }
    var valueEnd: CGFloat { get set }
    var animated: Bool { get set }

    var remainingColor: UIColor { get set }
    var progressColor: UIColor { get set }

    var progressLayer: CALayer { get }
}

extension Progress {
    func currentValue(_ value: CGFloat!) {
        
    }
}

extension Progress where Self: UIView {
    func currentValue(_ value: CGFloat!) {
        
    }
}
