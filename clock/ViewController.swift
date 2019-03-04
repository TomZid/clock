//
//  ViewController.swift
//  clock
//
//  Created by tom on 2019/3/4.
//  Copyright © 2019 NWD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var portraitFont = UIFont()
    var landScapeFont = UIFont()

    @IBOutlet weak var stackView: UIStackView!

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minutLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var mounthDayLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!

    @IBOutlet var tickLabel: [UILabel]!
    @IBOutlet var labelBackViews: [UIView]!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        portraitFont = self.hourLabel.font
        landScapeFont = {
            let font = UIFont.init(name: portraitFont.fontName, size: 100) ?? UIFont.systemFont(ofSize: 100)
            return font
        }()

        labelBackViews.forEach { (view) in
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
        }

        timerBegin()
    }



    func timerBegin() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
            let calendar = Calendar.init(identifier: .gregorian)

            var components = calendar.dateComponents([Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.weekday, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second], from: Date())

            self.hourLabel.text = String(components.hour!)
            self.minutLabel.text = String(components.minute!)
            self.secondLabel.text = String(format: "%02d", components.second!)
            self.mounthDayLabel.text = String(format: "%02d", components.month!) + "/" + String(format: "%02d", components.day!)
            self.weekLabel.text = {
                var week: String
                switch components.weekday! {
                case 1:
                    week = "星期日"
                case 2:
                    week = "星期一"
                case 3:
                    week = "星期二"
                case 4:
                    week = "星期三"
                case 5:
                    week = "星期四"
                case 6:
                    week = "星期五"
                case 7:
                    week = "星期六"
                default :
                    week = "星期一"
                }
                return week
            }()

            }
    }

    override var shouldAutorotate: Bool {
        var font = portraitFont

        switch UIDevice.current.orientation {
        case .portraitUpsideDown:
            stackView.spacing = 20
            font = portraitFont
        case .portrait:
            stackView.spacing = 20
            font = portraitFont
        case .landscapeLeft:
            stackView.spacing = 100
            font = landScapeFont
        case .landscapeRight:
            stackView.spacing = 100
            font = landScapeFont

        default:
            stackView.spacing = 20
            font = landScapeFont

        }

        hourLabel.font = font
        minutLabel.font = font
        secondLabel.font = font

        return true
    }

    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
//        let point = sender.translation(in: self.view)
//        let total = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)

        DispatchQueue.main.async {
            UIScreen.main.brightness = 0.0//(total - point.y) / total
        }
//        print("\(point.x), \(point.y)")
    }
}

protocol Then {}

extension Then where Self: AnyObject {
    func then(block: (Self) -> Void) -> Self {
    block(self)
    return self
    }
}

extension NSObject: Then{}

protocol Flip {}

extension Flip where Self: AnyObject {
    func flip(block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension UIView: Flip {}
