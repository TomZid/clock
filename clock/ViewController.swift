//
//  ViewController.swift
//  clock
//
//  Created by tom on 2019/3/4.
//  Copyright © 2019 NWD. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    var portraitFont = UIFont()
    var landScapeFont = UIFont()

    var previewValue: CGFloat = 0.1

    var pointBegin: CGPoint = CGPoint.zero
    var pointEnd: CGPoint = CGPoint.zero

    @IBOutlet weak var progressViewContainer: UIView!

    @IBOutlet weak var stackView: UIStackView!

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minutLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var mounthDayLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!

    @IBOutlet var tickLabel: [UILabel]!
    @IBOutlet var labelBackViews: [UIView]!

    @IBOutlet var longHoldGesture: UILongPressGestureRecognizer!
    @IBOutlet var panGesture: UIPanGestureRecognizer!

    var brightnessView: BrightnessIndexView?

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

        hideViewAnimate(in: progressViewContainer, ask: false)

        feedContentWithTime()
        timerBegin()
    }

    func timerBegin() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
            self.feedContentWithTime()
        }
    }

    func feedContentWithTime() {
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

    override var shouldAutorotate: Bool {
        var font = portraitFont

        switch UIDevice.current.orientation {
        case .portraitUpsideDown:
            stackView.spacing = 20
            stackView.axis = .vertical
            font = portraitFont
        case .portrait:
            stackView.spacing = 20
            stackView.axis = .vertical
            font = portraitFont
        case .landscapeLeft:
            stackView.spacing = 70
            stackView.axis = .horizontal
            font = landScapeFont
        case .landscapeRight:
            stackView.spacing = 70
            stackView.axis = .horizontal
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

    func showViewAnimate(in view: UIView, ask animate: Bool) {
        var time = 0.0
        if animate {
            time = 0.3
        }else {
            time = 0.0
        }
        UIView.animate(withDuration: time) {
            view.alpha = 1
        }
    }

    func hideViewAnimate(in view: UIView, ask animate: Bool) {
        var time = 0.0
        if animate {
            time = 0.3
        }else {
            time = 0.0
        }
        UIView.animate(withDuration: time) {
            view.alpha = 0
        }
    }

    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
        let total = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)

        var interval: CGFloat

        switch sender.state {
        case .began:
            showViewAnimate(in: progressViewContainer, ask: true)
            pointBegin = sender.location(in: view)
            pointEnd = sender.location(in: view)
        case .ended:
            hideViewAnimate(in: progressViewContainer, ask: true)
            fallthrough
        case .changed:
            pointEnd = sender.location(in: view)
            previewValue = UIScreen.main.brightness
        default:
            let _ = 1
        }

        interval = pointBegin.y - pointEnd.y

        UIScreen.main.brightness = interval / total + previewValue

        brightnessView?.currentProgress(UIScreen.main.brightness)
    }

    @IBAction func longTapAction(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            showViewAnimate(in: self.progressViewContainer, ask: true)

        } else if sender.state == .ended {
            hideViewAnimate(in: self.progressViewContainer, ask: true)
        }
    }

    // MARK:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BrightnessIndexView" {
            guard let viewController = segue.destination as? BrightnessIndexView else {
                return
            }
            brightnessView = viewController
        }
    }

    // MARK: UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // 滑动手势需要在长按手势触发后生效，否则滑动手势不触发
        if gestureRecognizer == panGesture {
            return longHoldGesture.state == .changed || longHoldGesture.state == .began
        } else {
            return true
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // 滑动手势与长安手势共同生效
        return true
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


