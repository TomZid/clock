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

    var previewValue: CGFloat = 0.1

    var pointBegin: CGPoint = CGPoint.zero
    var pointEnd: CGPoint = CGPoint.zero

    var progressView: ProgressView {
        get {
            let storyboard = UIStoryboard.init(name: "ProgressView", bundle: nil)
            return storyboard.instantiateInitialViewController() as! ProgressView
        }
    }

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

        previewValue = UIScreen.main.brightness

        portraitFont = self.hourLabel.font
        landScapeFont = {
            let font = UIFont.init(name: portraitFont.fontName, size: 150) ?? UIFont.systemFont(ofSize: 150)
            return font
        }()

        labelBackViews.forEach { (view) in
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
        }

        self.progressView.hide()

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
            stackView.spacing = 70
            font = landScapeFont
        case .landscapeRight:
            stackView.spacing = 70
            font = landScapeFont

        default:
            stackView.spacing = 70
            font = landScapeFont
        }

        hourLabel.font = font
        minutLabel.font = font
        secondLabel.font = font

        return true
    }

    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
        let total = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)

        var interval: CGFloat

        switch sender.state {
        case .began:
            self.progressView.show()
            pointBegin = sender.location(in: view)
            pointEnd = sender.location(in: view)
        case .ended:
            self.progressView.hide()
            fallthrough
        case .changed:
            pointEnd = sender.location(in: view)
            previewValue = UIScreen.main.brightness
        default:
            let _ = 1
        }

        interval = pointBegin.y - pointEnd.y

        UIScreen.main.brightness = interval / total + previewValue

    }
}

class ProgressView: UIViewController {
    func hide() {
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 0
        }
    }
    func show() {
        UIView.animate(withDuration: 0.3) {
            self.view.alpha = 1
        }
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


