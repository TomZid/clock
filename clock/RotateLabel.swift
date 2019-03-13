//
//  RotateLabel.swift
//  clock
//
//  Created by tom on 2019/3/13.
//  Copyright © 2019 NWD. All rights reserved.
//

import UIKit

class RotateClass: UILabel {

    func sizeFitWitFont(font: UIFont) -> CGSize {
        let textSize = (self.text! as NSString).size(withAttributes: [NSAttributedString.Key.font : font])
        return textSize
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if self.translatesAutoresizingMaskIntoConstraints == false {
            let textSize = self.sizeFitWitFont(font: self.font)
            for constraint in self.constraints {
                if constraint.firstAttribute == .width {
                    constraint.constant = textSize.height
                }else if constraint.firstAttribute == .height {
                    constraint.constant = textSize.width
                }
            }
            super.layoutSubviews()
        }
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.rotate(by: CGFloat(-(Double.pi/2)))

        let textSize = self.sizeFitWitFont(font: self.font)
        
        let middle = (self.bounds.size.width - textSize.height) / 2

        (self.text! as NSString).draw(at: CGPoint.init(x: -self.bounds.size.height, y: middle), withAttributes: [NSAttributedString.Key.font : self.font])

        context?.restoreGState()
    }

}
